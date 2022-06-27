Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D3B55CBB4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242203AbiF0XAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 19:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbiF0XAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 19:00:16 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B9120F61;
        Mon, 27 Jun 2022 16:00:15 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id p9so6749546ilj.7;
        Mon, 27 Jun 2022 16:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BBFolvCCjJnxhxohRNSfL/AQrqOPHqKgSw2LBcN2NnQ=;
        b=bfXVza1My8NSlUM8fMnH6rlEd9095RBvJGqKsD3Zsdz7rTOiJnG252FT3Sb/axL2E1
         cHTl+aYPFp1SNDQZ79q/9KrLR+p9sndPKTqGIup2ydW+V02jbfongpRrmXx8ENLS4mJX
         UXAVwVviNmomi0kmLf/qNF+iKR46jlnAMlNQxomIuBW8UFtK7nhAtfBdaS627M1KdopS
         xqSfRf+57ma3Z8tHl6DljT5HQbtiNsQMtK66X46s15KUPRzyupoTB4rdTn2cdQdLNhmu
         bR94PUVvOqY4TUyaEffV8Xr3x4sDAta0ybSrJC/b55lV//7JLUEUj9HaTJ6mjtS2/mHs
         YysQ==
X-Gm-Message-State: AJIora+Yhm21t4Q9bqmh40J4StOcbHE0IldgvsqGTP3tAVuV90qX8tA4
        2bnHhiiSFVT/MbdvomkViw==
X-Google-Smtp-Source: AGRyM1s3mDmWtHR9KacZ3brBzVulekXmlkOSi7niZLvqZ3o/vbqhjQZ0fgaGh7zEyYExAh29I7iuRQ==
X-Received: by 2002:a05:6e02:154d:b0:2da:9539:3093 with SMTP id j13-20020a056e02154d00b002da95393093mr4813252ilu.131.1656370814723;
        Mon, 27 Jun 2022 16:00:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u18-20020a92ccd2000000b002d8d813892csm5083745ilq.8.2022.06.27.16.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:00:14 -0700 (PDT)
Received: (nullmailer pid 3126600 invoked by uid 1000);
        Mon, 27 Jun 2022 23:00:12 -0000
Date:   Mon, 27 Jun 2022 17:00:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        krzk+dt@kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ASoC: dt-bindings: fsl-sai: Add new property to
 configure dataline
Message-ID: <20220627230012.GA3122063-robh@kernel.org>
References: <1655451877-16382-1-git-send-email-shengjiu.wang@nxp.com>
 <1655451877-16382-7-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655451877-16382-7-git-send-email-shengjiu.wang@nxp.com>
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

On Fri, Jun 17, 2022 at 03:44:36PM +0800, Shengjiu Wang wrote:
> "fsl,dataline" is added to configure the dataline of SAI.
> It has 3 value for each configuration, first one means the type:
> I2S(1) or PDM(2), second one is dataline mask for 'rx', third one is
> dataline mask for 'tx'. for example:
> 
> fsl,dataline = <1 0xff 0xff 2 0xff 0x11>,
> 
> it means I2S type rx mask is 0xff, tx mask is 0xff, PDM type
> rx mask is 0xff, tx mask is 0x11 (dataline 1 and 4 enabled).
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index c71c5861d787..4c66e6a1a533 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -49,6 +49,14 @@ Required properties:
>  			  receive data by following their own bit clocks and
>  			  frame sync clocks separately.
>  
> +  - fsl,dataline        : configure the dataline. it has 3 value for each configuration
> +                          first one means the type: I2S(1) or PDM(2)
> +                          second one is dataline mask for 'rx'
> +                          third one is dataline mask for 'tx'.
> +                          for example: fsl,dataline = <1 0xff 0xff 2 0xff 0x11>;
> +                          it means I2S type rx mask is 0xff, tx mask is 0xff, PDM type
> +                          rx mask is 0xff, tx mask is 0x11 (dataline 1 and 4 enabled).

You mean 0 and 4 enabled? Or 1 and 4?

How many 3 cell entries can you have?

Rob
