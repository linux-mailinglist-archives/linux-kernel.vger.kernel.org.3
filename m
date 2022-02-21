Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D24A4BE423
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377332AbiBUOKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:10:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377318AbiBUOKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:10:22 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9C61EAC2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:09:58 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id e5so17661581vsg.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7+WcxmhaLYcJ+8pluGn0/oWg/SAXibHCywaoZcD3M+k=;
        b=CUb60dhdXmw4ncFzQuHXXsgnJnX7JNIF197o+EN3b+b+wyYQ8vLLr9cBpaBOgj3r/s
         NgoyMjGyrv5Uy1jX0NoFJbsjmJMCGppdOlovWoHRdlnDd7V9ZNKCGYQXtAhhOOjxr5La
         MeRZzs42F1R6QyzbMaOXRm1lp+qh/ZL4znWP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7+WcxmhaLYcJ+8pluGn0/oWg/SAXibHCywaoZcD3M+k=;
        b=Ps27fzCqb/d3pkQUpPqwneRyfRTUYy7ytp0oVB/eWstMCtvcwsI5qA55UTWlUGp0v4
         0N2dPD0GvG/SLTkstxN0pRe587/SCJvl92qr7mdQbfVqLDO5jZ6/X6qMGDGMLIw2tzKy
         BoFPARTvJfSMujPVXiTfULP6erSCVLzDFX8d1HCbT5S9SSWe8O0jN4NbCgZ/FwJjmVGl
         pydKymdx4lMJfdFBe56N+Daf7qjFbfL7/42tIINbzdx90QXhK2HfQuqHVRH2v4Z0XXY6
         88dtSKHZ0PnVvZwZ8bkIM06QHTQSAGtQQz5my4duaDBLTFG4pO4esdBcte9Ki4b+HxgN
         ss5w==
X-Gm-Message-State: AOAM531doMeoG0+ptS1k9MPRT83Y/V+yIh2qnB50G6HFLO8cY8pAadUK
        wnmxix2zj+VEr9v2aDcfbEtZwTrKcjn3z04/LyupoQ==
X-Google-Smtp-Source: ABdhPJyQMpd7yYaTSY0oqRBS+NVBJD9xwwqBnymrxaPZ/UfchwBdEYzHUvnV66r3tYDpNqKJHCvEr7U1+zqYVkjcrQQ=
X-Received: by 2002:a05:6102:15ac:b0:31b:fc94:f0de with SMTP id
 g44-20020a05610215ac00b0031bfc94f0demr6436149vsv.48.1645452598020; Mon, 21
 Feb 2022 06:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20220110235252.138931-1-jlayton@kernel.org>
In-Reply-To: <20220110235252.138931-1-jlayton@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Feb 2022 15:09:47 +0100
Message-ID: <CAJfpegswypcKcFAk3+wvJ9xg098Nik02_dT1PLUnsRRLdmrZSg@mail.gmail.com>
Subject: Re: [PATCH] fuse: move FUSE_SUPER_MAGIC definition to magic.h
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 at 00:52, Jeff Layton <jlayton@kernel.org> wrote:
>
> ...to help userland apps that need to identify FUSE mounts.

Thanks, applied.

Miklos
