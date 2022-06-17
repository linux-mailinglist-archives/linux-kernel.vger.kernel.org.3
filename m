Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0C754FECB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383507AbiFQUlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383451AbiFQUky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:40:54 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC60A62234;
        Fri, 17 Jun 2022 13:38:13 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id d6so3711315ilm.4;
        Fri, 17 Jun 2022 13:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lIp97u+lxIFSYVVpClAb3I0MjJEMZHlf6DTQj2ciqMQ=;
        b=B+kNf3Qe2B4fGZlrcZu7sWg2sYJxH98fH6Lflhh6+WCKPvIZMbAO4vMUdcUQ3mSiiI
         dESbANcQ3yUXhTnWgHeeqJOb3A125gAgUQkeB2bEVVWeLcXZciZcfETrBsiDN9DP0/Vy
         1+KYSHticiLr84w4yxdAAIVTleHjh5kjH/NSCeicrSGKLXUUw/pFj80H066I2SN9kj4q
         mxAQ5V/PGSeDsKyYFlcNnF4gDV6X9UsW8tpk2EQ70ZokNTopL4psEN7ul1ny7A73n133
         8VcAQ8cLjiVCJDSA8nZy18X9p+nPI9k1tpJqgiCzCP6nsB9QnJW54Nr9xpI8JH67xj9y
         MW8g==
X-Gm-Message-State: AJIora8Ozu2dJnu1fRWqaIcLy27c4hTGpkEmpSJkjgDB4YeNxhyDPKQ7
        NIWCT9CNo9bqvll86DYgmDWSAY3lUA==
X-Google-Smtp-Source: AGRyM1sx3PAL1Quk/UBT8qbGkhruHp0QZRIVk9eb+fOx7gKisQNd9qR7XfPmFzHc6UxEQMX9edQw/g==
X-Received: by 2002:a05:6e02:184a:b0:2d3:9f38:138a with SMTP id b10-20020a056e02184a00b002d39f38138amr6187322ilv.124.1655498232872;
        Fri, 17 Jun 2022 13:37:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id q20-20020a02a314000000b0032e9bf3b973sm2654013jai.5.2022.06.17.13.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:37:12 -0700 (PDT)
Received: (nullmailer pid 2400596 invoked by uid 1000);
        Fri, 17 Jun 2022 20:37:09 -0000
Date:   Fri, 17 Jun 2022 14:37:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     wefu@redhat.com, robh+dt@kernel.org, atishp@atishpatra.org,
        krzk+dt@kernel.org, hch@lst.de, devicetree@vger.kernel.org,
        palmer@dabbelt.com, cmuellner@linux.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, samuel@sholland.org,
        philipp.tomsich@vrull.eu, mick@ics.forth.gr, drew@beagleboard.org,
        guoren@kernel.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org
Subject: Re: [PATCH 1/3] dt-bindings: riscv: document cbom-block-size
Message-ID: <20220617203709.GA2400541-robh@kernel.org>
References: <20220610004308.1903626-1-heiko@sntech.de>
 <20220610004308.1903626-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610004308.1903626-2-heiko@sntech.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2022 02:43:06 +0200, Heiko Stuebner wrote:
> The Zicbom operates on a block-size defined for the cpu-core,
> which does not necessarily match other cache-sizes used.
> 
> So add the necessary property for the system to know the core's
> block-size.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
