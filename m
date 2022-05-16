Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3453A5295A6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350491AbiEPX7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 19:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344851AbiEPX7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 19:59:02 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CB440936;
        Mon, 16 May 2022 16:59:01 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-e656032735so22378854fac.0;
        Mon, 16 May 2022 16:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FaxCfcz4ZedEdhGKxThXh5xPLoC1+SoU0EDepYrDXJ8=;
        b=dGwje39WObfrrrbcJ6yMV5l9Ar7p8j4vRQvBH7x16MRKgIxbd32VWWTkvANh3rFC9I
         THdoPPRwfoo+ck6og93o0zBmHFyAfLEztnlZFkzHzx9utVeaHy0bSJMgTIEvbFbW5DkM
         hbgJxi5YliSNAX+sf2u9EwOBgmCbhRck34H6jVRUfUgJZg+605UjNRMOR0n5hrAwYltB
         OUVWH6OzkQqiX6ZOuSj14qXnx8HnYXThnTKV+AkrAK5cE8fYb9XTTdnvuzIEsFj1FTcY
         SxlkRo5mxsRRX5yw0B+voxMHnUluYlDZ3FlbHhSlWxjKX68n0ogGa0QgUh84+SxSCLVS
         P3yg==
X-Gm-Message-State: AOAM533BiQHEvSftps1JiXsvk+jGD0bivVgGHj2PePV60QQcp9kYmCew
        1eoHaMtekaI0g54r0itA3w==
X-Google-Smtp-Source: ABdhPJz1ZWl21sZayYNAlf/AV250Dn0ztlX9VgBjpJXO7XS4jKaeqO8eYco4Fgsv3n8/U7F/z3KMOQ==
X-Received: by 2002:a05:6870:d113:b0:f1:8a78:bfba with SMTP id e19-20020a056870d11300b000f18a78bfbamr6202023oac.95.1652745541097;
        Mon, 16 May 2022 16:59:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w133-20020acadf8b000000b00326414c1bb7sm4299873oig.35.2022.05.16.16.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 16:59:00 -0700 (PDT)
Received: (nullmailer pid 3589630 invoked by uid 1000);
        Mon, 16 May 2022 23:58:59 -0000
Date:   Mon, 16 May 2022 18:58:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, phone-devel@vger.kernel.org,
        linux-input@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Lin Meng-Bo <linmengbo0689@protonmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: input/touchscreen: Add compatible for
 IST3038B
Message-ID: <20220516235859.GA3589595-robh@kernel.org>
References: <20220504152406.8730-1-markuss.broks@gmail.com>
 <20220504152406.8730-3-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504152406.8730-3-markuss.broks@gmail.com>
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

On Wed, 04 May 2022 18:24:04 +0300, Markuss Broks wrote:
> Imagis IST3038B is a variant (firmware?) of Imagis IST3038 IC,
> add the compatible for it to the IST3038C bindings.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
