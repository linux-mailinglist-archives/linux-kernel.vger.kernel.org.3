Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6094E2234
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345250AbiCUIbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240827AbiCUIbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:31:32 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066AC457BC;
        Mon, 21 Mar 2022 01:30:07 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id j5so10922180qvs.13;
        Mon, 21 Mar 2022 01:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=78b/Tf9x9t1olBlaa+56sY8ZBbEFc/5hUD4AQ2ShuLU=;
        b=gang1LPexcCyvNtwBHfisAaP++v3Po6xQDASiBS5oNyhDBqAZHRbDUJiFIPM1bF3Ii
         8uJxKOoezD0YzN29JdEfmlEDSkQn9edKPoNDyDzkZ6BOq6UbsDjbbAnpXyGwyYW/Ili2
         aAuuUCrsR/xyOjHycqC/Ef9jLsO0u9LjvBwKjW1uibAKDiGgEAlCO83GUD3fxE7WMost
         jJz37lJe2/WBYiMSbYsms8JfcFsO79T1bIx4gxv0MJUiYWdvXl/xfgOVJ4pyDm0ut3kF
         V7KJ8XIOF6KfUw2l7+NETeYUdu3alfPuUXZe9FwjQqBoWNSavTf45loSYwM8bVVvJCE+
         m9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=78b/Tf9x9t1olBlaa+56sY8ZBbEFc/5hUD4AQ2ShuLU=;
        b=sIb2U6iUgSAG2/RHaRMM+sqKZJsazJw4bXyxJSXv5P0l9pj/5NDsf6XQDF1bse7dGN
         wgL2UaUu88htFJlSRh5JbStN/R3ArsQK7LzofJOP+SWWSULUeNQrRyAFNjnp/KEkOKvC
         xJ0kaz6pqueupzy1pjH8OQt1hw06Jwqh31xw4PMzgnOsZqUCKV2qGPuaIlJuKc6vZjmf
         z5kd6w7i9KVCf5pun25ODvD2EqewjKvu7AP7tnNz+7V56yGVxfvjjGNuOG4K1UsHRwr3
         xyoENbYLeDEq+5xyv7juu1ZvthXJmnHUxTO99hJfwelSm6HLKC3KE2aqR+9vwmAbpKTW
         Zpqw==
X-Gm-Message-State: AOAM5307swKllTaa8Q1chW5WpTJJCobt1NFcsEXqAyHlTYp0rnnPB9dH
        JNim9HQI46TCGbGbYoFOE22NLQ4gdr8=
X-Google-Smtp-Source: ABdhPJwgw6xAEDKyTGZeQ7hNwS8ggLQFlRBbezPA7jzQaqSdUdHVaE8ATwdAH2KI6pmSYykPG1nCWw==
X-Received: by 2002:a05:6214:5008:b0:440:f4a5:ec76 with SMTP id jo8-20020a056214500800b00440f4a5ec76mr12964241qvb.25.1647851406085;
        Mon, 21 Mar 2022 01:30:06 -0700 (PDT)
Received: from vps.qemfd.net (vps.qemfd.net. [173.230.130.29])
        by smtp.gmail.com with ESMTPSA id w1-20020ac857c1000000b002e1e899badesm11298202qta.72.2022.03.21.01.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 01:30:05 -0700 (PDT)
Received: from schwarzgerat.orthanc (schwarzgerat.danknet [192.168.128.2])
        by vps.qemfd.net (Postfix) with ESMTP id 1A1062B6E2;
        Mon, 21 Mar 2022 04:30:05 -0400 (EDT)
Received: by schwarzgerat.orthanc (Postfix, from userid 1000)
        id 0F5B560041C; Mon, 21 Mar 2022 04:30:05 -0400 (EDT)
Date:   Mon, 21 Mar 2022 04:30:05 -0400
From:   nick black <dankamongmen@gmail.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     "G. Branden Robinson" <g.branden.robinson@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [patch] console_codes.4: ffix
Message-ID: <Yjg3jXCAsjQVHJAi@schwarzgerat.orthanc>
References: <YeEc2pYvKEckcAmv@schwarzgerat.orthanc>
 <CAN4uE+p-uKzHNYry2YhCMfEFBQ2jUqpDAGx=+eha01w-L4fAjg@mail.gmail.com>
 <20220320160217.gws42lklp6ishzub@localhost.localdomain>
 <fd0b3fea-4b40-ffba-442f-00908a5335a9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd0b3fea-4b40-ffba-442f-00908a5335a9@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alejandro Colomar (man-pages) left as an exercise for the reader:
> nick, can you please resend the patch?  I've lost the original email.

Fix up the busted OSC command list (reset palette and
set palette). Remove CSI prefix from the list of non-CSI
escapes. End all items of said list with periods,
matching other sections of the page.

Signed-off-by: nick black <nickblack@linux.com>
---
 man4/console_codes.4 | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git man4/console_codes.4 man4/console_codes.4
index d549b76a9..001de1955 100644
--- man4/console_codes.4
+++ man4/console_codes.4
@@ -139,29 +139,28 @@ T}
 ESC 8	DECRC	T{
 Restore state most recently saved by ESC 7.
 T}
-ESC [	CSI	Control sequence introducer
 ESC %		Start sequence selecting character set
 ESC % @		\0\0\0Select default (ISO 646 / ISO 8859-1)
 ESC % G		\0\0\0Select UTF-8
 ESC % 8		\0\0\0Select UTF-8 (obsolete)
 ESC # 8	DECALN	T{
-DEC screen alignment test \- fill screen with E's
+DEC screen alignment test \- fill screen with E's.
 T}
 ESC (		T{
 Start sequence defining G0 character set
 (followed by one of B, 0, U, K, as below)
 T}
 ESC ( B		T{
-Select default (ISO 8859-1 mapping)
+Select default (ISO 8859-1 mapping).
 T}
 ESC ( 0		T{
-Select VT100 graphics mapping
+Select VT100 graphics mapping.
 T}
 ESC ( U		T{
-Select null mapping \- straight to character ROM
+Select null mapping \- straight to character ROM.
 T}
 ESC ( K		T{
-Select user mapping \- the map that is loaded by the utility \fBmapscrn\fP(8)
+Select user mapping \- the map that is loaded by the utility \fBmapscrn\fP(8).
 T}
 ESC )		T{
 Start sequence defining G1 (followed by one of B, 0, U, K, as above).
@@ -169,12 +168,13 @@ T}
 ESC >	DECPNM	Set numeric keypad mode
 ESC =	DECPAM	Set application keypad mode
 ESC ]	OSC	T{
-(Should be: Operating system command)
-ESC ] P \fInrrggbb\fP: set palette, with parameter
-given in 7 hexadecimal digits after the final P :-(.
-Here \fIn\fP is the color (0\(en15), and \fIrrggbb\fP indicates
+Operating System Command prefix.
+T}
+ESC ] R		Reset palette.
+ESC ] P		T{
+Set palette, with parameter given in 7 hexadecimal digits \fInrrggbb\fP after
+the final P. Here \fIn\fP is the color (0\(en15), and \fIrrggbb\fP indicates
 the red/green/blue values (0\(en255).
-ESC ] R: reset palette
 T}
 .TE
 .ad
-- 
2.34.1

-- 
nick black -=- https://www.nick-black.com
to make an apple pie from scratch,
you need first invent a universe.
