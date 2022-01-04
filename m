Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1528E483A4B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiADCAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiADCAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:00:01 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA032C061761;
        Mon,  3 Jan 2022 18:00:00 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q16so73055675wrg.7;
        Mon, 03 Jan 2022 18:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6bmFeTc+ASL2yNsdNEmUhNJpDw6o3ieqtOPJDyurw4U=;
        b=jOU18gpNI07BebDSx25i0IEy4j+B13FpovX+vvFFZplKvaxLme6lEYRIZzvqYSLrYG
         PTBgOsasKKdpjhQFTC+guybHmUjn1HZYrONe7Tai6qCXzSl9Po7OJmwSqu4K6z/UPvJO
         b/B0ylJ41dCCe3WeLQ0oztorMZ4l6eY+GEUqBED7wPaqu0w5Ct+reycAJWmK4hJowtft
         5KeuPIBYtTrEJBD0aq189J4q9Vkcm89UofrP3qzO4efJaYHBaaQ6vriU+CshQimNqFm2
         9vHlIRtKKqG37rQ8XB0xytEInxYcI5tLY/ANnBZw+GBW6gLYWlakGBRNOVz6Oc0i9lQg
         GtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6bmFeTc+ASL2yNsdNEmUhNJpDw6o3ieqtOPJDyurw4U=;
        b=qZJMky6cGZQX6d3TTd0bAzVzLZsBzTdBPsauagNwbuvyKYKUvM01vcshPlt4FmiWRF
         bYrM4SkWug4NDHs9qYQooOVJBdzGG0VFtv81Nd3fDAOJLcyIcibk7Lhuem/oVmqhttIa
         BqAkJ1oeXHMV1EIhb94vQ4wtvIe7oOSMgo8R6fNoq1F4ufARm9KRAtvGIeRMbOxGOV+h
         qJ1shwkXd9w7miZkeaNRXcdbO9dxC9thvVaMRsAoXlxS4RDUhkwlmvcVrXrv8TxZ5yTd
         mZMWE4Y24inC91oXz6NSuFfbpVRblJlyNXwwIllsSU+qUWTqjnFruMqbNA6jTqzTfaSx
         OGyw==
X-Gm-Message-State: AOAM532S4F3wN9CdurD0GVhmos8U4K1QFzKdVsXxzuOvpW5FFsSllUE0
        jy9rISNQj5rWETOdRwV43nbTM5DR6U4Alw==
X-Google-Smtp-Source: ABdhPJzpk9BAgAbip5RHU77Ozz3FaOjB2Np4QEC/+tTOQ6sTsCwqd4ABSDyfpTA+CrlMaX0inH1w4g==
X-Received: by 2002:a05:6000:104f:: with SMTP id c15mr40103559wrx.665.1641261599260;
        Mon, 03 Jan 2022 17:59:59 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id j17sm36422654wrp.68.2022.01.03.17.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 17:59:58 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/15] Transform documentation into POD
Date:   Tue,  4 Jan 2022 02:59:31 +0100
Message-Id: <20220104015946.529524-1-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series transforms the free-form general comments - mainly the usage
instructions and the meta information - into the standard Perl
documentation format. Some of the original text is reduced out.

The transformation includes language, paragraphing and editorial
corrections.

The only change in the script execution flow is the replacement of the
'usage' function with the native standard Perl 'pod2usage'.

The TODO suggestion to write POD found in the script is ancient, thus
I can't address its author with a "Suggested-by" tag.

The process consists of 15 steps.

Patches beginning with no 4 are disfunctional until no 10 has been
applied.

This version is in fact the first correction of v1. The first attempt to
send it was a failure due to my lack of experience. It was weird in other
ways too. Never mind the details.

What I'm sending now mostly follows the advice received for v1. My reply is
contained in the patches otherwise. I have also done a few bits differently
to v1, as I found better solutions, etc.

Ok, let's see how it gets through this time.

PS. Jani Nikula and Jonathan Corbet - sorry for bothering you with a copy of
		emails with you tagged in them that I sent to myself. This was unexpected.

Tomasz Warniełło (15):
  scripts: kernel-doc: Add the NAME section
  scripts: kernel-doc: Add the SYNOPSIS section
  scripts: kernel-doc: Relink argument parsing error handling to
    pod2usage
  scripts: kernel-doc: Translate the DESCRIPTION section
  scripts: kernel-doc: Translate the "Output format selection"
    subsection of OPTIONS
  scripts: kernel-doc: Translate the "Output format selection modifier"
    subsection of OPTIONS
  scripts: kernel-doc: Translate the "Output selection" subsection of
    OPTIONS
  scripts: kernel-doc: Translate the "Output selection modifiers"
    subsection of OPTIONS
  scripts: kernel-doc: Translate the "Other parameters" subsection of
    OPTIONS
  scripts: kernel-doc: Replace the usage function
  scripts: kernel-doc: Remove the "format of comments" comment block
  scripts: kernel-doc: Archive the pre-git museum
  scripts: kernel-doc: License cleanup
  scripts: kernel-doc: Refresh the copyright lines
  scripts: kernel-doc: Move the TODOs

 scripts/kernel-doc | 390 ++++++++++++++++++++++-----------------------
 1 file changed, 194 insertions(+), 196 deletions(-)


base-commit: 2a987e65025e2b79c6d453b78cb5985ac6e5eb26
-- 
2.30.2

