Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EBC523301
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbiEKMVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiEKMVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:21:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598FD517EB;
        Wed, 11 May 2022 05:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B6E7B82346;
        Wed, 11 May 2022 12:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33212C340F2;
        Wed, 11 May 2022 12:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652271657;
        bh=cUMLjJflIOfZrDUwXHRIoEjaf+o1/RjF/ghlAYMkhz0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=MCQ+p3dayIVOo8hzCseOeYoDSIPRdyI3MInbx2okCDtw6v2RgdZUQrNxpHuXkx9wL
         3DY7uhF5P3A6cIP9NAaCAaxbG9QZ9/Yb4f47px5sQMhn+SYaRP0uSupxoB7TLqwUDR
         EA+/XKbFHvAFJ0j/SkmrrCEYX0gvV/lVMpkN2vbszdVczsDUUCmf1LMnTCqookeuSr
         HvzeFvoFYUo0cfcNiDA6+Ow9vWy5NMnq9iuAwbsC0lk4fsFATZImePk74VK4c8h9lF
         aIGLw2EsY00GJRDAkhPFDBn1fMggqer9gGXe+6IxQJ9WQNeUTa2ZI/Sb7bWOeb2Pzt
         U4l/UcIBMuSlA==
Date:   Wed, 11 May 2022 14:20:53 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, albertofanjul@gmail.com
Subject: Re: [PATCH for-5.19/uclogic 0/7] DIGImend patches, part VI
In-Reply-To: <20220508160146.13004-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2205111420210.28985@cbobk.fhfr.pm>
References: <20220508160146.13004-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 May 2022, José Expósito wrote:

> Hi everyone,
> 
> This series is a follow up to [1], [2], [3], [4] and [5] upstreaming
> 7 more patches from the DIGImend project.
> 
> After 3 months, I'm happy to write that this is the last batch of
> patches :) Once the patchset is applied, DIGImend and the mainline
> kernel will have the same code... And I'll finally add support for my
> tablet. This should also allow Stefan and Alberto to continue with
> their work.

This is now in hid.git#for-5.19/uclogic. Thanks for all the work,

-- 
Jiri Kosina
SUSE Labs

