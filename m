Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B2948E465
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiANGtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiANGtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:49:00 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8758FC061574;
        Thu, 13 Jan 2022 22:49:00 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 82so10011254qki.10;
        Thu, 13 Jan 2022 22:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=B+fcba0guNJe05QgbJXwe+sMQe2m5ccQ8ajqhjcvHAE=;
        b=ecmU7hZRNGjPS2XiyC0x8KenUkgVcZzEzqPlRh5jPDVUOuLvmP8aKk9OkWhIdvwWCJ
         T097GxzoxSze7MoQR9hVpF2UxBYH+TFUbAAqX1ffTCXIBTbnTit4Nvc4CBhn4bRvCxs+
         6rO9P6L12CyL5KAhjyTwPxanbieM7dAMSx2vBPpIyxZNywCUhEFYvh++oljd1vYNqgS4
         0EglfMrjsN3+Ywy1gGHALjWmtsf6vDsbES7K9bJRIF/gFWZKRmiaPGGD2C0+IIDZDFEA
         khuEOJcEYWOrWASuBwJEmEH7ruvVVejYu7UozhUMKCLeHseJbr5EtfqhhgMAABF4HVla
         owVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=B+fcba0guNJe05QgbJXwe+sMQe2m5ccQ8ajqhjcvHAE=;
        b=1KhQDO5VL0DicffcZZEyjANJKYpa5R8tl4jCuZ4rK1R+E7sCheDyF9Lx9seV89Zxbm
         08twJD3CyC3D9ggwsaz0M5QNml7Q56NZrdMQajQQHGVAzHOmReIMnVYqGclJI4q+L/TJ
         c+b6V2h39eOjvjnNUwrtoCcGYEVso4vZ4LhQ32etO13Oe6Ttf5zlazjVzUgA9VnNJPgn
         sFdJxlIqa2poGcT3VsAKyPD7H/QASnVg7m+IgGL5ePfmhHQpPNYDPHoxY4K9lGjS/b52
         3aqZutr5BP2PtWU35bUBuXvCecAycFvum84ibQPl/qc5pMDBOSOF5ApY/HzXn7IyFMNl
         PQGQ==
X-Gm-Message-State: AOAM530cgX8zEymAiWEY/38LMLxjhMWfAVvUkAPDrubEi6CpeHtU3hsA
        eGnwpJGA5Za5md9AZRwe/sk8i38TgrE=
X-Google-Smtp-Source: ABdhPJxpLJfkcIKmkzQboS/h9TEkXvXV4sh4EWp3uO/wDl8oH9bNtbWjfmEvNMtuTjduCYallcj9BA==
X-Received: by 2002:a05:620a:f10:: with SMTP id v16mr5485570qkl.626.1642142939650;
        Thu, 13 Jan 2022 22:48:59 -0800 (PST)
Received: from vps.qemfd.net (vps.qemfd.net. [173.230.130.29])
        by smtp.gmail.com with ESMTPSA id w9sm563358qkp.89.2022.01.13.22.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 22:48:59 -0800 (PST)
Received: from schwarzgerat.orthanc (schwarzgerat.danknet [192.168.128.2])
        by vps.qemfd.net (Postfix) with ESMTP id 7A6DA2B5D4;
        Fri, 14 Jan 2022 01:48:58 -0500 (EST)
Received: by schwarzgerat.orthanc (Postfix, from userid 1000)
        id 75B24600305; Fri, 14 Jan 2022 01:48:58 -0500 (EST)
Date:   Fri, 14 Jan 2022 01:48:58 -0500
From:   nick black <dankamongmen@gmail.com>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [patch] console_codes.4: ffix
Message-ID: <YeEc2pYvKEckcAmv@schwarzgerat.orthanc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
