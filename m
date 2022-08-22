Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8C659C8D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbiHVT37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238761AbiHVT3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:29:40 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312604F65F;
        Mon, 22 Aug 2022 12:24:09 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id o15-20020a9d718f000000b00638c1348012so8381090otj.2;
        Mon, 22 Aug 2022 12:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=8zy7YCWL5YZTEH0yzkezpqZ96keenfHSDIKWTIiVfgw=;
        b=ADXtPQ0Zl0lz8VdHyI2ow6pdVOSGSxaLMhEEKIUHXfX/uqASKhc9MY9DnCeM2tKFhY
         Rr6iIJoNMuYM6R9yfC6LiZZ6iC02g2IffcsHEVfdvgwPoXCt1ZOUAbAPS5tOtUZvn+Gw
         MlMTq4rxS65TbwVhnQ0s6GfRVipID4s0R+xiWM3R2a5ndnSv1WGttVETSDfG0JoiBvz0
         QOqk1i/QmGokI2MC/x+lBcy0jFjBHe7LVX2UxtgvRJ8Xk/Stj3rTNYfuGvLB7mET2/9U
         insjQFJuuY4KLWoARUAxayNKclTz6EO2pfJOo1Pp+L7CSXIr2q1LjCZI46XN6GOO+vFa
         dwZQ==
X-Gm-Message-State: ACgBeo1CtAkDzrshnQhYQvkVdtmUvCTWFt4eXCU28y1goQ7JVRan8tkz
        uJnoUaycwIjFc7I4zx76AQ==
X-Google-Smtp-Source: AA6agR4Yhy+q1icNwprzoYLj6JYDzQtQ1J/JCtznjaPHD+6F092GBaDf5PsttXwKM4eRbJgkp/cPdg==
X-Received: by 2002:a05:6830:90c:b0:637:18c0:b750 with SMTP id v12-20020a056830090c00b0063718c0b750mr7936744ott.385.1661196188346;
        Mon, 22 Aug 2022 12:23:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m3-20020a0568301e6300b00636d6571ff7sm3059517otr.70.2022.08.22.12.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:23:07 -0700 (PDT)
Received: (nullmailer pid 296993 invoked by uid 1000);
        Mon, 22 Aug 2022 19:23:06 -0000
Date:   Mon, 22 Aug 2022 14:23:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mithil Bavishi <bavishimithil@gmail.com>
Cc:     tony@atomide.com, dmitry.torokhov@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        sre@kernel.org, linux-pm@vger.kernel.org, contact@paulk.fr,
        linux@armlinux.org.uk
Subject: Re: [PATCH 02/10] dt-bindings: power: reset: Move twl4030-power from
 mfd to power/reset
Message-ID: <20220822192306.GA296915-robh@kernel.org>
References: <20220820071659.1215-1-bavishimithil@gmail.com>
 <20220820071659.1215-3-bavishimithil@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820071659.1215-3-bavishimithil@gmail.com>
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

On Sat, 20 Aug 2022 12:46:52 +0530, Mithil Bavishi wrote:
> Move the documentation for twl4030-power from mfd to power/reset
> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
> ---
>  .../devicetree/bindings/{mfd => power/reset}/twl4030-power.txt    | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{mfd => power/reset}/twl4030-power.txt (100%)
> 

Acked-by: Rob Herring <robh@kernel.org>
