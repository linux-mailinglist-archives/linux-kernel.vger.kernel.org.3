Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F274842AA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiADNmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:42:08 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:53391 "EHLO
        lizzy.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiADNmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:42:07 -0500
X-Greylist: delayed 2034 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 08:42:07 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
        Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
        Content-Description; bh=KK6K6A1ewu0NicnXXmv6oM0+oO1hXvzidLdOaL7jDRI=; b=XtaaN
        7k8n6vpdfPgI4ZsTBWWvbEp/7+CmRqz7iodCvzsU+8n7V6WwnnVhgP7QvToChUQ3X8POgUO6pUE64
        VQCRu+NeblMRCMQcDaI0l71BcKKGicB5vVVG3PUfOuypOL919A38c0JD8w62iuDYkW3xeXw4Zo7Gv
        T8KwNvvn3Pv787mWa/knMOyzKxb2coNFlvs2caeIKUSmStBW0IwQD6CGWzMy+iEfL08EbrzxSOcrg
        nCuFEYuMwWr+HoqvQ1AZDVq9z+7w4a0FARAvrSOHkyCXWm+KvUa04aO8F/N1ulEazbdOsY4ZIniv4
        /c6dCHJB5cWIuWFcHQsoUASPlAigQ==;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
Date:   Tue, 4 Jan 2022 13:53:59 +0100
Subject: [PATCH] 9p: add myself as reviewer to MAINTAINERS
To:     linux-kernel@vger.kernel.org
Cc:     v9fs-developer@lists.sourceforge.net,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>, Greg Kurz <groug@kaod.org>
Message-Id: <E1n4jXv-000445-GK@lizzy.crudebyte.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Volunteering as reviewer for 9p patches. As I am quite familiar with the
9p code base in the Linux kernel already, plus being current maintainer
of 9p in QEMU this move probably makes sense.

Signed-off-by: Christian Schoenebeck <linux_oss@crudebyte.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb18ce7168aa..c8db00be639b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -226,6 +226,7 @@ F:	drivers/net/ethernet/8390/
 M:	Eric Van Hensbergen <ericvh@gmail.com>
 M:	Latchesar Ionkov <lucho@ionkov.net>
 M:	Dominique Martinet <asmadeus@codewreck.org>
+R:	Christian Schoenebeck <linux_oss@crudebyte.com>
 L:	v9fs-developer@lists.sourceforge.net
 S:	Maintained
 W:	http://swik.net/v9fs
-- 
2.30.2

