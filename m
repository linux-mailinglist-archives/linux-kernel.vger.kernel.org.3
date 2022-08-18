Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C3D598A40
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344834AbiHRRTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344728AbiHRRSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:18:12 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37CB383;
        Thu, 18 Aug 2022 10:15:46 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id w8so1127434ilj.5;
        Thu, 18 Aug 2022 10:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=UWsf+zlgyhNyjO5Y7JQSuQwv4XP3mzyiE5nZk/xIkL0=;
        b=7Bzoe4HHwEj4+r84ZrUBQuQrj2NyjjuMXouAlWe/PBjWyOcAqK2sHncqnef2rSHHmt
         u+fGx8MD8BIZ5S1fVQK5SLAvnlrsp4ZiV9W0npQV7EglxS6UCkC4JS0r141W3ZNbCESu
         UFkwBqmhTu9Hvj7Zcqyk5ZpeN6DKc62N8RPOgwNUKTU/bqXFffsa69oRlbyL7+hmTmqs
         TEmzhTn1EgNcb3+5/uwuzB4OxcMuVdJdJyBpAokJOyGJS2Lubt5oL1rFZIaYBhwc8qj9
         rG/hl6ZWcAJWPDgabi5BXpPDeHT1dnd9ppZJVfJbF0K4j4EU1j6UWFjLPKmxfxF5FZra
         4AuA==
X-Gm-Message-State: ACgBeo0wVysaD4GgcLtoZz+A2jo/nGn0vuer//obfMvOaP7Q0FdOaMa+
        0FsG4a277UgvJ37DTMZCSQ==
X-Google-Smtp-Source: AA6agR5Veo8vJr6OZE+PXLhrBYUKE7szY3eTD73CFkv6Jb6VaIbgetV13AQzlMpPWH/NxWZ9e3NNVg==
X-Received: by 2002:a05:6e02:1685:b0:2df:2dd5:80f3 with SMTP id f5-20020a056e02168500b002df2dd580f3mr1870031ila.17.1660842946004;
        Thu, 18 Aug 2022 10:15:46 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:647:4ff2:3529:f8cd:d6cd:ac54])
        by smtp.gmail.com with ESMTPSA id e4-20020a92de44000000b002e904093c5dsm828143ilr.44.2022.08.18.10.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 10:15:45 -0700 (PDT)
Received: (nullmailer pid 2050959 invoked by uid 1000);
        Thu, 18 Aug 2022 17:15:43 -0000
Date:   Thu, 18 Aug 2022 11:15:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: qcom,sm8250: add compatibles for
 sm8450 and sm8250
Message-ID: <20220818171543.GH1978870-robh@kernel.org>
References: <20220818135817.10142-1-srinivas.kandagatla@linaro.org>
 <20220818135817.10142-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818135817.10142-2-srinivas.kandagatla@linaro.org>
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

On Thu, Aug 18, 2022 at 02:58:15PM +0100, Srinivas Kandagatla wrote:
> Add compatibles for sm8450 and sm8250xp based soundcards.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
