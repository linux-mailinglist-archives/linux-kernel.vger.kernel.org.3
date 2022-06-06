Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6E653ECDF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiFFRRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiFFRRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:17:08 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86B742A08;
        Mon,  6 Jun 2022 10:13:04 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id a10so12866952ioe.9;
        Mon, 06 Jun 2022 10:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T5YHzXRjPtC200vv9hoqJeGGEkRGnL+7w3QqiAQN+TM=;
        b=r/PkSlzOFDleKY8iBXGdTPhHXApoXgdg5JBlVIhE9JCZqOA3nVMn5bhQ7AX5FvaMvX
         w87CcWULq9WixwmB+eJ6v6tDbZPeI5WzQmQqAf/wTK673Gczw9EsxqlSFknErzm3jDx8
         pYQQkJhAG8kNsWmW4ZO2sHCwplgwzSkMOZpz/6ZLjZyEjxrup9WKKqLSsWXe0PUTmBz4
         UgrUFNoxUZQO0mxyTK3aMCffvga1/QOHa1BOMyGkdyjpmlCEfLodJmew0VdiuXpVjxOn
         qVpgDLdjdCEsNadMDKySgHd2uBoiOfvvYy+VGNPVTJquMSO/OFz1Nm9JHqvdw+DrfCM3
         +AkA==
X-Gm-Message-State: AOAM5303xqbEP6sE0fa/vJIynT8LSbcr38r+i6qtLiFSY9yezld1Brr6
        jatDvyjiEjWUDb8hi65qNA==
X-Google-Smtp-Source: ABdhPJz2y+CCdx3q0SwKpY+tb7SzPRSL0+ZHCKWijihTGCxh7qxVlU0vcmJrL7FUNCRk3ErsgKwXEA==
X-Received: by 2002:a5d:9a96:0:b0:669:50d6:815 with SMTP id c22-20020a5d9a96000000b0066950d60815mr3580524iom.110.1654535584095;
        Mon, 06 Jun 2022 10:13:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id i41-20020a026029000000b0033155f242f0sm5810134jac.23.2022.06.06.10.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 10:13:03 -0700 (PDT)
Received: (nullmailer pid 904364 invoked by uid 1000);
        Mon, 06 Jun 2022 17:13:01 -0000
Date:   Mon, 6 Jun 2022 12:13:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH 14/23] MAINTAINERS: update arm,hdlcd.yaml reference
Message-ID: <20220606171301.GA899329-robh@kernel.org>
References: <cover.1654529011.git.mchehab@kernel.org>
 <714c3b6e10736d51268b9d71b97829a224b3bae1.1654529011.git.mchehab@kernel.org>
 <20220606163401.13e5bea3@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606163401.13e5bea3@donnerap.cambridge.arm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 04:34:01PM +0100, Andre Przywara wrote:
> On Mon,  6 Jun 2022 16:25:36 +0100
> Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
> 
> Hi Mauro,
> 
> > Changeset 36fd2a65bcaf ("dt-bindings: display: convert Arm HDLCD to DT schema")
> > renamed: Documentation/devicetree/bindings/display/arm,hdlcd.txt
> > to: Documentation/devicetree/bindings/display/arm,hdlcd.yaml.
> > 
> > Update its cross-reference accordingly.
> 
> So Lukas sent the same thing already last week:
> https://lore.kernel.org/linux-kernel/20220601041746.22986-1-lukas.bulwahn@gmail.com/
> 
> His patch covered all of the three ARM display updates (14, 15, 16/23
> in this series) in one go.
> Not sure where to go from here, or if Lukas' patch already made it
> somewhere.

I'll apply that one.

Rob
