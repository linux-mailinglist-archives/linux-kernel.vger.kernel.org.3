Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2490501C14
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345818AbiDNTo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbiDNTo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:44:27 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E49BC84C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:42:01 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 141so4885337qkf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mTODUQcmfHMXq3ycnA48JyJoU23qtMYGGZvxAogIduI=;
        b=J11JHHp+k6h93DRPv9GxhRTdkIyDSoPNvBepsNjSkaqgQd3zSice+Ln0lNLmZJ8dGy
         L+GN12biJbCjJx5REbVAYgbFnAaDYN5xcxGgmGn/WpOezwcUTI/tsPHRgs0SwGm0Hqf5
         oFXhdGr5dcPxt9ma+Zev9Ozawsp30U7NaR1g9Q4euZwyZKH5HXxyFeG5nX9sd9phIXOU
         +EFNN1N+Y7ohQWKfPNApmIWSHtHct8TI02lPqsY7r14m2JiO6oDvvWxOnGq31xmX4gB6
         CysFh3b+dr3gLqbMWh/EIlrunCFoUgPSoWhqAOqEHIYEH8xl1L8LNUfd6snJ9adbINbu
         iI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mTODUQcmfHMXq3ycnA48JyJoU23qtMYGGZvxAogIduI=;
        b=wu5OB8QR68NlSS+hT8GSRCvDcHosLPD0FxXt0hbLlKfTEdMIEIISv2yXb7d/MXh/np
         isN2hDwmTjV503f2KF8k9CUZZqaxkS6ZGSSjixA4aJ+NRtupVLC9PKhgTKnxzEXeM5Ui
         Doz5tY0K3BfQMfxOHfsfStF9MwEXLlbQgnizEE8P2uzHn9eudBTFXorI9ck0gVwrS5Ql
         BMe7XZWDpBRWxmLwpTF7hSVwDyjQcuiZRIpsoA0LzlUmV6vQg5c8GJwLL+CiMWax6n8Y
         JLWEjSlqlO0LO4hUEo8Mi0IrlutsyaZUXZ0Bg2uC+3tWmvXEJjpVQdkfnoMudVeZzTs6
         asUQ==
X-Gm-Message-State: AOAM532GXGFT2HwF6JdA/dUTZlsxed/XnBimAfHrF980an4JzP7BMFd2
        1AzKpwvtJban02NWx2TCZPk=
X-Google-Smtp-Source: ABdhPJyUBJLR/ybTeUMPng6XWPxe2qytprEupIR8YWUPQ7Th3wRiREJiReSp+6PuNz89uDk2494Z9g==
X-Received: by 2002:a37:807:0:b0:69c:7f73:32f8 with SMTP id 7-20020a370807000000b0069c7f7332f8mr2469446qki.665.1649965320803;
        Thu, 14 Apr 2022 12:42:00 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id t19-20020ac85893000000b002e1afa26591sm1857873qta.52.2022.04.14.12.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 12:41:59 -0700 (PDT)
Date:   Thu, 14 Apr 2022 15:41:55 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH 3/6] staging: r8188eu: remove 'added by' author comments
Message-ID: <20220414194155.GB4144553@jaehee-ThinkPad-X1-Extreme>
References: <cover.1649880454.git.jhpark1013@gmail.com>
 <c0c0a0e748ad85585b65e73841d431adefe86a59.1649880454.git.jhpark1013@gmail.com>
 <2eab9c9e-7e56-9920-de4d-2e53b3d7e6a1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eab9c9e-7e56-9920-de4d-2e53b3d7e6a1@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 11:28:31PM +0300, Pavel Skripkin wrote:
> Hi Jaehee,
> 
> On 4/13/22 23:11, Jaehee Park wrote:
> > Author comments "Added by Albert" and "Added by Annie" are sprinkled
> > through the file. Git will keep history so these comments can be
> > removed from the code.
> > 
> 
> these people are not in the git log, since this driver was added in 2021. I
> am afraid they are not even in Larry's GH repo log.
> 
> Anyway these comments are not so useful, so patch is OK.

Thank you, I'll update the patch log message.

> 
> With regards,
> Pavel Skripkin
