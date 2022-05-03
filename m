Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CD2517B86
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 03:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiECBPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 21:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiECBPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 21:15:17 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266941122;
        Mon,  2 May 2022 18:11:36 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id h10-20020a056830400a00b00605e92cc450so8843547ots.11;
        Mon, 02 May 2022 18:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6idLREmYEsyr7Qq/r5oT1b0rYJzqTwFyOTejQXnDpus=;
        b=ORAsLPHNvNfb9KDzg+1r2j+laHOAAPtfRR/51OTPVuFCdwWHTD19CVzvkEzXJvUKs0
         FtmERSFNoBjUi7GZhznGd9YcFWF2F0Rf7LSFyOfFKwY/ruW3BkbmwGAHi5JvzELDnMD5
         N6Y7tWj6Cj6zz1nA4VLemCSGq68LhPbiYt/vQe9QZalUGAqhgsAFKMAtlfhXQ32SLL/r
         xueS0q9vw5mQpL9XT2YLZgOnusZ2ulMlM6ycDKbvjzQYBQ/eFzQcUhfIHRan8iIC/+kc
         pqa0u/YWMFl/v6u2ARlkXGG52gphCIDQwnfY346xiN6OgxmGqQx8fGwwpThwDzGxQIAF
         6GGw==
X-Gm-Message-State: AOAM531yPn62SlxUyQfLszhRIK04VUimSwSR62MtNuxZvBJuLMot/GTG
        NPJtMJnCrr0HE1H8rqbd0JCGLgEOJQ==
X-Google-Smtp-Source: ABdhPJzoXPBJOStsJ3h4Yi6gzu9HZl3LfhTobnlthRvr6PEGX/uIzSskFe5uzn/gUSc8Qzho/dtTVA==
X-Received: by 2002:a05:6830:61c:b0:606:15a7:1619 with SMTP id w28-20020a056830061c00b0060615a71619mr2942781oti.115.1651539400183;
        Mon, 02 May 2022 17:56:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e7-20020a056870944700b000e686d13884sm6412169oal.30.2022.05.02.17.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 17:56:39 -0700 (PDT)
Received: (nullmailer pid 2155296 invoked by uid 1000);
        Tue, 03 May 2022 00:56:38 -0000
Date:   Mon, 2 May 2022 19:56:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devicetree@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Slawomir Stepien <sst@poczta.fm>
Subject: Re: [PATCH v2 1/3] of: overlay: add entry to of_overlay_action_name[]
Message-ID: <YnB9xnGT4Vx3ba9X@robh.at.kernel.org>
References: <20220502181742.1402826-1-frowand.list@gmail.com>
 <20220502181742.1402826-2-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502181742.1402826-2-frowand.list@gmail.com>
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

On Mon, 02 May 2022 13:17:40 -0500, frowand.list@gmail.com wrote:
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
> Changes since version 1:
>   - patch 1/1 v1 did not apply on Rob's dt/next branch, rebase on top of
>     5f756a2eaa44 of: overlay: do not break notify on NOTIFY_{OK|STOP}
> 
>  drivers/of/overlay.c | 27 +++++----------------------
>  include/linux/of.h   | 13 +++++++++++++
>  2 files changed, 18 insertions(+), 22 deletions(-)
> 

Applied, thanks!
