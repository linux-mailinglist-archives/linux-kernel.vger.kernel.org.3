Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FFC4EF80C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345513AbiDAQhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349610AbiDAQgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:36:53 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA43189A04;
        Fri,  1 Apr 2022 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1648829506; i=@motorola.com;
        bh=YeQIqoGThc8urtgwTdfFd0hpcomzfYgoZUG1awzffy8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding;
        b=bJjZ6jkCnh6BuOkrrwput47dSxinVaUQMipkQcdzu9nAMZMar3EX5vrMuKcLegg5L
         XVDlMHVKYcRuFIH1xycCGtqaR5le7BevvL9U5hpVB0f27lXYT/xLlxFmnya86R1/BU
         /bd0xte5kpnnbR7LvT+FwyFAi8TxCtaJxVGHMj9wgaweK3rES9ijxB6n2X9/b299Er
         GFeHo8HUIy733uA+tbstdEJ6xhOYsqy2rRPOffYe2Chz+5RdIQ1mZfVC78o8OC/1tV
         e9u27JL9zZwo0zEkLdxv7epleb79AdqPujlyKb4HE3uwr0uOeMQK6kR4jBKBJw3YK1
         qFtffvQ59swfQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRWlGSWpSXmKPExsWS8eKJuK6jinu
  SwZcNChbH2p6wW8zZHG3x5EA7o0Xz4vVsFp0Tl7BbLGxbwmJxedccNotFy1qZLR7Ovspo8fbO
  dBYHLo/ZHTNZPTav0PLYtKqTzWP/3DXsHov7JrN6fN4k53Fo+xu2APYo1sy8pPyKBNaMddMLC
  95oVGzo38LWwDhTqYuRi0NIYAaTRNO3aawQzlImiXNnv7F0MXJysAmoSSx4vYoZxBYRkJU4fO
  U3M0gRs0AHs8TP9YvZQRLCAgESkzqXghWxCKhK7Do9B6yZV8Bc4vT2jYwgtoSAvMSpZQeZIOK
  CEidnPgGrYQaKN2+dzTyBkXsWktQsJKkFjEyrGK2TijLTM0pyEzNzdA0NDHQNDU10zUx1DS2N
  9RKrdBP1Sot1UxOLS3SN9BLLi/VSi4v1iitzk3NS9PJSSzYxAsM4pcjx4A7GQ6t+6h1ilORgU
  hLlnavkniTEl5SfUpmRWJwRX1Sak1p8iFGGg0NJgveSAlBOsCg1PbUiLTMHGFMwaQkOHiUR3o
  eyQGne4oLE3OLMdIjUKUZdjkuHruxlFmLJy89LlRLn5VAGKhIAKcoozYMbAYvvS4yyUsK8jAw
  MDEI8BalFuZklqPKvGMU5GJWEecVApvBk5pXAbXoFdAQT0BH6N1xBjihJREhJNTDd9lpdp7Tt
  sIERo3z1k2t3ukWypWOL469uLc2Njl7hs2SRZ1JgzvLuTp/LTx9/+9e7iyXXpvvx+i8XTh5fW
  V5VHGvhfTblS8iTjP4Uo8iCdcoHjMU/iC2bw9zQ8F11Rlaj1hGuG2InbiQtT1/1dE2I9/S3C9
  n9mBfuCi7seaSV6LXo1A+Zxf032QKFFJ4UZZ71nGS05cmBhz9ffk8Wk1ptw7v/McdRUUXRGQa
  fs6qKcq9GHF3wfOKhtrvZdwTWvNmiaZtdvllu6+VtsU18i96y6O9jWSfaHfPGpnQ5O3/g4WXf
  +Pwbd/e0x3SG+pUYMa2s8ntw0kbx+YI09k9vVux5N/3y94qIbWc5FDMZlfYqsRRnJBpqMRcVJ
  wIAQeYN+moDAAA=
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-3.tower-715.messagelabs.com!1648829505!14608!1
X-Originating-IP: [104.232.228.23]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29768 invoked from network); 1 Apr 2022 16:11:45 -0000
Received: from unknown (HELO va32lpfpp03.lenovo.com) (104.232.228.23)
  by server-3.tower-715.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Apr 2022 16:11:45 -0000
Received: from va32lmmrp01.lenovo.com (va32lmmrp01.mot.com [10.62.177.113])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by va32lpfpp03.lenovo.com (Postfix) with ESMTPS id 4KVQCj0xTlz50WfM;
        Fri,  1 Apr 2022 16:11:45 +0000 (UTC)
Received: from p1g3.. (unknown [10.45.5.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by va32lmmrp01.lenovo.com (Postfix) with ESMTPSA id 4KVQCh55QWzf6f8;
        Fri,  1 Apr 2022 16:11:44 +0000 (UTC)
From:   Dan Vacura <w36195@motorola.com>
To:     linux-usb@vger.kernel.org
Cc:     Dan Vacura <w36195@motorola.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Carlos Bilbao <bilbao@vt.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2] usb: gadget: uvc: allow changing interface name via configfs
Date:   Fri,  1 Apr 2022 11:04:45 -0500
Message-Id: <20220401160447.5919-1-w36195@motorola.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a configfs entry, "function_name", to change the iInterface field
for VideoControl. This name is used on host devices for user selection,
useful when multiple cameras are present. The default will remain "UVC
Camera".

Signed-off-by: Dan Vacura <w36195@motorola.com>
---
Changes in v2: 
- remove stable cc

 .../ABI/testing/configfs-usb-gadget-uvc       |  1 +
 Documentation/usb/gadget-testing.rst          |  1 +
 drivers/usb/gadget/function/f_uvc.c           |  4 +-
 drivers/usb/gadget/function/u_uvc.h           |  1 +
 drivers/usb/gadget/function/uvc_configfs.c    | 41 +++++++++++++++++++
 5 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc b/Documentation/ABI/testing/configfs-usb-gadget-uvc
index 889ed45be4ca..611b23e6488d 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
@@ -7,6 +7,7 @@ Description:	UVC function directory
 		streaming_maxburst	0..15 (ss only)
 		streaming_maxpacket	1..1023 (fs), 1..3072 (hs/ss)
 		streaming_interval	1..16
+		function_name		string [32]
 		===================	=============================
 
 What:		/config/usb-gadget/gadget/functions/uvc.name/control
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index c6d034abce3a..1c37159fa171 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -787,6 +787,7 @@ The uvc function provides these attributes in its function directory:
 	streaming_maxpacket maximum packet size this endpoint is capable of
 			    sending or receiving when this configuration is
 			    selected
+	function_name       name of the interface
 	=================== ================================================
 
 There are also "control" and "streaming" subdirectories, each of which contain
diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 71bb5e477dba..50e6e7a58b41 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -44,7 +44,7 @@ MODULE_PARM_DESC(trace, "Trace level bitmask");
 #define UVC_STRING_STREAMING_IDX		1
 
 static struct usb_string uvc_en_us_strings[] = {
-	[UVC_STRING_CONTROL_IDX].s = "UVC Camera",
+	/* [UVC_STRING_CONTROL_IDX].s = DYNAMIC, */
 	[UVC_STRING_STREAMING_IDX].s = "Video Streaming",
 	{  }
 };
@@ -676,6 +676,7 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	uvc_hs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 	uvc_ss_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 
+	uvc_en_us_strings[UVC_STRING_CONTROL_IDX].s = opts->function_name;
 	us = usb_gstrings_attach(cdev, uvc_function_strings,
 				 ARRAY_SIZE(uvc_en_us_strings));
 	if (IS_ERR(us)) {
@@ -866,6 +867,7 @@ static struct usb_function_instance *uvc_alloc_inst(void)
 
 	opts->streaming_interval = 1;
 	opts->streaming_maxpacket = 1024;
+	snprintf(opts->function_name, sizeof(opts->function_name), "UVC Camera");
 
 	ret = uvcg_attach_configfs(opts);
 	if (ret < 0) {
diff --git a/drivers/usb/gadget/function/u_uvc.h b/drivers/usb/gadget/function/u_uvc.h
index 9a01a7d4f17f..24b8681b0d6f 100644
--- a/drivers/usb/gadget/function/u_uvc.h
+++ b/drivers/usb/gadget/function/u_uvc.h
@@ -27,6 +27,7 @@ struct f_uvc_opts {
 
 	unsigned int					control_interface;
 	unsigned int					streaming_interface;
+	char						function_name[32];
 
 	/*
 	 * Control descriptors array pointers for full-/high-speed and
diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index 77d64031aa9c..63b8d3758b38 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -2425,10 +2425,51 @@ UVCG_OPTS_ATTR(streaming_maxburst, streaming_maxburst, 15);
 
 #undef UVCG_OPTS_ATTR
 
+#define UVCG_OPTS_STRING_ATTR(cname, aname)				\
+static ssize_t f_uvc_opts_string_##cname##_show(struct config_item *item,\
+					 char *page)			\
+{									\
+	struct f_uvc_opts *opts = to_f_uvc_opts(item);			\
+	int result;							\
+									\
+	mutex_lock(&opts->lock);					\
+	result = snprintf(page, sizeof(opts->aname), "%s", opts->aname);\
+	mutex_unlock(&opts->lock);					\
+									\
+	return result;							\
+}									\
+									\
+static ssize_t f_uvc_opts_string_##cname##_store(struct config_item *item,\
+					  const char *page, size_t len)	\
+{									\
+	struct f_uvc_opts *opts = to_f_uvc_opts(item);			\
+	int ret = 0;							\
+									\
+	mutex_lock(&opts->lock);					\
+	if (opts->refcnt) {						\
+		ret = -EBUSY;						\
+		goto end;						\
+	}								\
+									\
+	ret = snprintf(opts->aname, min(sizeof(opts->aname), len),	\
+			"%s", page);					\
+									\
+end:									\
+	mutex_unlock(&opts->lock);					\
+	return ret;							\
+}									\
+									\
+UVC_ATTR(f_uvc_opts_string_, cname, aname)
+
+UVCG_OPTS_STRING_ATTR(function_name, function_name);
+
+#undef UVCG_OPTS_STRING_ATTR
+
 static struct configfs_attribute *uvc_attrs[] = {
 	&f_uvc_opts_attr_streaming_interval,
 	&f_uvc_opts_attr_streaming_maxpacket,
 	&f_uvc_opts_attr_streaming_maxburst,
+	&f_uvc_opts_string_attr_function_name,
 	NULL,
 };
 
-- 
2.32.0

