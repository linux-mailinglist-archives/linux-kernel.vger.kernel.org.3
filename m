Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E444838D1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 23:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiACWgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 17:36:55 -0500
Received: from ms.lwn.net ([45.79.88.28]:51062 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229876AbiACWgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 17:36:54 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EB4FC4A6;
        Mon,  3 Jan 2022 22:36:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EB4FC4A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1641249414; bh=wdaP/UD105480aBAEV/T+Q8YTQ/bJvNQykTevNi4HK8=;
        h=From:To:Cc:Subject:Date:From;
        b=BtWn+UUPRghAT2LUpA02qgiVEwsbq8NnX33g/Nu97i77ddzezFrl1j0hjAl7w0a3H
         FVYhpwRbzNqEkrvrLiPSzZ7FiWzR/1qrwIleqof9JjBC9LZf1tOnhvTZ1w7iuuZYn7
         9m479FDJr6nR5/9/3qWr81190Av+4+eWNW942uZukDgL1awDr+Ju4OYY0u/jOEnybT
         9qOsk3M90mU9YA9WtW+41zhjEi1gSD7+1xW6AjsvdbhJTCQnG1lennG8DDk7OggNqd
         Op+nNGSDsYGT3db+syjhIDO547Q1vBscVtUp1Cb4wOKB+Hbuw3zM0d3idVHOsSRuOI
         q60R9CFV3pv9w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] docs: discourage use of list tables
Date:   Mon, 03 Jan 2022 15:36:56 -0700
Message-ID: <87r19oxx87.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our documentation encourages the use of list-table formats, but that advice
runs counter to the objective of keeping the plain-text documentation as
useful and readable as possible.  Turn that advice around the other way so
that people don't keep adding these tables.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/doc-guide/sphinx.rst | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 673cbb769c08..bb36f18ae9ac 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -261,12 +261,11 @@ please feel free to remove it.
 list tables
 -----------
 
-We recommend the use of *list table* formats. The *list table* formats are
-double-stage lists. Compared to the ASCII-art they might not be as
-comfortable for
-readers of the text files. Their advantage is that they are easy to
-create or modify and that the diff of a modification is much more meaningful,
-because it is limited to the modified content.
+The list-table formats can be useful for tables that are not easily laid
+out in the usual Sphinx ASCII-art formats.  These formats are nearly
+impossible for readers of the plain-text documents to understand, though,
+and should be avoided in the absence of a strong justification for their
+use.
 
 The ``flat-table`` is a double-stage list similar to the ``list-table`` with
 some additional features:
-- 
2.33.1

