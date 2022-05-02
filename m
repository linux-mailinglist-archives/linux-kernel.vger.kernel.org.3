Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C9451753F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350851AbiEBRDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbiEBRDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:03:34 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F053D117C;
        Mon,  2 May 2022 10:00:04 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-ed9ac77cbbso4251808fac.1;
        Mon, 02 May 2022 10:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jL/zMMM/g6RvJvTqfaL3AxSBlJb7ZiFgbTZ+tEyGEr4=;
        b=Hit/lFohIUyiIJtfRb/ySKReRMPF1jI4j53sm32NbpEOSu7CmUOU3ppN29cpDZJhOC
         g0JpiP3iNAmkKqfRR6meY6Li1BwlXgg975rS7yeL2wrZAi9Ipzgns6dT/Hpan/va+UxA
         TUPCHS4owpt4tiWg99lKNfDnxKo6VA2ZDQ59Uin2eYYYFK71HQwD9GW/yt6cVrwUehGz
         edgx5CwHNHrTq3FI8GMDUODk+WN61unrOUAam+UjJgrDA9FVZK7aWxH8XRem6dQn4ONX
         prPnEnNB89vVFM0Dp57evgrO2atlgAe4oJpwzYOv0/RBXuXeO1UOEF63qHeyDxeERwKV
         0DAw==
X-Gm-Message-State: AOAM532WH64oFr2wULUEJSGs8xtGoemz6OzIPkY4atHDsQOx+jpAiJJU
        NV5b9SgUWXX4M2iFZ9Y8ZA==
X-Google-Smtp-Source: ABdhPJyY8oqsNJ1CkInSExC9VYH++2hzZpE32bzXuh8V61fPi/nB1xZYHIdlXv08Rw5VQKyDhNR4zA==
X-Received: by 2002:a05:6870:4610:b0:e9:a4a0:84 with SMTP id z16-20020a056870461000b000e9a4a00084mr48677oao.76.1651510804141;
        Mon, 02 May 2022 10:00:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h23-20020a4adcd7000000b0035eb4e5a6bbsm4033884oou.17.2022.05.02.10.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 10:00:03 -0700 (PDT)
Received: (nullmailer pid 1331045 invoked by uid 1000);
        Mon, 02 May 2022 17:00:02 -0000
Date:   Mon, 2 May 2022 12:00:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/3] of: overlay: add entry to of_overlay_action_name[]
Message-ID: <YnAOEqO23BQk53vz@robh.at.kernel.org>
References: <20220501000543.1368005-1-frowand.list@gmail.com>
 <20220501000543.1368005-2-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501000543.1368005-2-frowand.list@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 07:05:41PM -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> The values of enum of_overlay_notify_action are used to index into
> array of_overlay_action_name.  Add an entry to of_overlay_action_name
> for the value recently added to of_overlay_notify_action.
> 
> Array of_overlay_action_name[] is moved into include/linux/of.h
> adjacent to enum of_overlay_notify_action to make the connection
> between the two more obvious if either is modified in the future.
> 
> The only use of of_overlay_action_name is for error reporting in
> overlay_notify().  All callers of overlay_notify() report the same
> error, but with fewer details.  Remove the redundant error reports
> in the callers.
> 
> Fixes: 067c098766c6 ("of: overlay: rework overlay apply and remove kfree()s")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/overlay.c | 27 +++++----------------------
>  include/linux/of.h   | 13 +++++++++++++
>  2 files changed, 18 insertions(+), 22 deletions(-)

This isn't applying for me.

Rob
