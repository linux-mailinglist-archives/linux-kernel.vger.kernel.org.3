Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7494B271C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350552AbiBKNas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:30:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344706AbiBKNar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:30:47 -0500
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FE21BF;
        Fri, 11 Feb 2022 05:30:46 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id m185so11304301iof.10;
        Fri, 11 Feb 2022 05:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yXYDTPVyzNL3HdggD9t7igGwyc5OPXWVE0t2GHzk0/Y=;
        b=mvChhF84A/muZ+yiXbQMw7yGhOxlZyzgKoX7/Wgh2LdHkTXVB3oCi6YKXd8KCq566N
         UGmCqV7kAjZU8UCO00rRfoL/o4gT7Iy6ab/WtaQuAIrd8AOucGQOWu8sXmgzdEB59mct
         GGv95inNK3HRg1Wyr7gCpnOn5SaXPwdw9v9aWvdjypHCG+cBEkuHE6Shl1wwUTcht9/X
         6qS59rIe+7Ure/Ip+cd+HKaWafeh3KWVqRIOAMcRBFSW1Cd1NXLyz/zg3p5WwM7hAAb4
         m1MVv9DouPwuIHxhnsWrGStgSy3AfTfhuBeBDxL8tF4a5iVtv/mB6XGeLy8w/t6FWK02
         C/RA==
X-Gm-Message-State: AOAM531s3Upmtbw9R6qqOn7wawF1piLpFixSTF05YUFbmMjF55dwPpqi
        Y7plgrpXy3D2mOXhOmknVi1gj5IajA==
X-Google-Smtp-Source: ABdhPJz0I90OIyzyeltUDleVrE7USdaTR5yvb//9XL91SKkbLY5srdLk2U1GTdfIJKY/EPJVn7xunQ==
X-Received: by 2002:a05:6638:d0c:: with SMTP id q12mr835349jaj.310.1644586245902;
        Fri, 11 Feb 2022 05:30:45 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.139.71])
        by smtp.gmail.com with ESMTPSA id h3sm13445127ioe.19.2022.02.11.05.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 05:30:45 -0800 (PST)
Received: (nullmailer pid 259753 invoked by uid 1000);
        Fri, 11 Feb 2022 13:30:41 -0000
Date:   Fri, 11 Feb 2022 07:30:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     quentin.schulz@theobroma-systems.com
Cc:     thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel@ffwll.ch, robh+dt@kernel.org,
        sam@ravnborg.org, dri-devel@lists.freedesktop.org,
        Quentin Schulz <foss+kernel@0leil.net>, airlied@linux.ie
Subject: Re: [PATCH 3/3] dt-bindings: ltk050h3146w: add compatible for
 LTK050H3148W-CTA6 variant
Message-ID: <YgZlASpL4uurqroZ@robh.at.kernel.org>
References: <20220131164723.714836-1-quentin.schulz@theobroma-systems.com>
 <20220131164723.714836-3-quentin.schulz@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131164723.714836-3-quentin.schulz@theobroma-systems.com>
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

On Mon, 31 Jan 2022 17:47:23 +0100, quentin.schulz@theobroma-systems.com wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> The LTK050H3148W-CTA6 is a 5.0" 720x1280 DSI display, whose driving
> controller is a Himax HX8394-F, slightly different from LTK050H3146W by
> its init sequence, mode details and mode flags.
> 
> Cc: Quentin Schulz <foss+kernel@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  .../devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml  | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
