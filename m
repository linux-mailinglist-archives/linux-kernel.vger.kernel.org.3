Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF12D472F77
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbhLMOhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239566AbhLMOhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:37:03 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB389C06173F;
        Mon, 13 Dec 2021 06:37:02 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id m15so14717727pgu.11;
        Mon, 13 Dec 2021 06:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hPzEtIR5ZtJ5eM8ckZIgqY9yEf/L65TTT3C247oGC+g=;
        b=qvb8vDEEGd5ADi3XflSwmGStc/TPYlI1lzLTQgr6DYT6HFIEwLm+WVGjARpZPYmyJF
         pmPwCgd0usg+iFn7BYn1uinXHv0MqkD3EiGBd2jJUX+EtnTkqyaluUyBrP2M8+GN3oyq
         FptaNqjMeUyOubZviwxCpWl/5yul/cr0BApLtV1tdqyNqtRYFJY52o6GNKnb0TMWV9XT
         BDNtK4QSpNEfZRzKHL47xGbb7SJF7nerH6iCUxUma6oYdtZ9+zvAYln02CqQD9RfQZn0
         w6KfMLWMuTghGuX7mSeHJRASuSE1ny+D+OVN2c4RX3pFYWjMJlxBFc5b2j56aUxLU++s
         lSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hPzEtIR5ZtJ5eM8ckZIgqY9yEf/L65TTT3C247oGC+g=;
        b=deIA0iq//fDo6+RoRL5n8MBLqGw48rJleIZ65HzWQGRCXRjbThX4Hcd6NoR+/LP2Wu
         hZ6BW2iPKtCuRJq6Aa15eHlnlALV1KeL7ZNs4u/rZLV/AtQM3CU3IFnUgekFzMKSzR8g
         am96VNDuinzhPO+otz2ndcO2kIeAf8jOpacfC0VwvVl/RHIhs+JW/9xBlboQd+P5Hblx
         oYDPrsfEm9BMcitjpg5OvTS9NpTuMCkb08QzFjCmGgnnpQPaPcyuFNXf8jWt24UurxB3
         +aoyDCj6m2OMGe6B2C/eSyOGTWs7DlE3cbzmVFgvh38DSd1hNkYBkTI77k3YjiNFcbnm
         Seqw==
X-Gm-Message-State: AOAM533e06i2Yzu0iJoRCZcMLy/ZYpLg/kqy8eYdGYyEvUVZNSbRHz99
        kOb/1O/3tgtTg4/8fxEphds=
X-Google-Smtp-Source: ABdhPJzua/fec9hQ/kaaLlVgFU7yTEwlZWxT5tSFhYm4gdHpBJeXE4GiKbYZlElA4oThxG5tsjq2BA==
X-Received: by 2002:a63:1c8:: with SMTP id 191mr19393457pgb.615.1639406222311;
        Mon, 13 Dec 2021 06:37:02 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 13sm9154673pfp.216.2021.12.13.06.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 06:37:01 -0800 (PST)
Subject: [PATCH 4/3] docs: sphinx/kfigure.py: Add check of 'dot -Tpdf'
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <92cc6573-4eed-047e-0e9d-4b0e96aa6649@gmail.com>
Date:   Mon, 13 Dec 2021 23:36:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent any regression on existing build systems, limit the
fallback of converting DOT -> raster PDF only when all of the
following conditions are met.

 o dot(1) doesn't support -Tpdf
 o rsvg-convert(1) is not found
 o inkscape(1) is not found

Suggested-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/sphinx/kfigure.py | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/sphinx/kfigure.py b/Documentation/sphinx/kfigure.py
index d5802e3975e5..dbe75ee8ae61 100644
--- a/Documentation/sphinx/kfigure.py
+++ b/Documentation/sphinx/kfigure.py
@@ -113,6 +113,8 @@ def pass_handle(self, node):           # pylint: disable=W0613
 
 # Graphviz's dot(1) support
 dot_cmd = None
+# dot(1) -Tpdf should be used
+dot_Tpdf = False
 
 # ImageMagick' convert(1) support
 convert_cmd = None
@@ -175,7 +177,7 @@ def setupTools(app):
 
     This function is called once, when the builder is initiated.
     """
-    global dot_cmd, convert_cmd, rsvg_convert_cmd   # pylint: disable=W0603
+    global dot_cmd, dot_Tpdf, convert_cmd, rsvg_convert_cmd   # pylint: disable=W0603
     global inkscape_cmd, inkscape_ver_one, inkscape_show_warn  # pylint: disable=W0603
     kernellog.verbose(app, "kfigure: check installed tools ...")
 
@@ -186,6 +188,16 @@ def setupTools(app):
 
     if dot_cmd:
         kernellog.verbose(app, "use dot(1) from: " + dot_cmd)
+
+        try:
+            dot_Thelp_list = subprocess.check_output([dot_cmd, '-Thelp'],
+                                    stderr=subprocess.STDOUT)
+        except subprocess.CalledProcessError as err:
+            dot_Thelp_list = err.output
+            pass
+
+        dot_Tpdf_ptn = b'pdf'
+        dot_Tpdf = re.search(dot_Tpdf_ptn, dot_Thelp_list)
     else:
         kernellog.warn(app, "dot(1) not found, for better output quality install "
                        "graphviz from https://www.graphviz.org")
@@ -197,6 +209,7 @@ def setupTools(app):
         inkscape_ver_one = re.search(ver_one_ptn, inkscape_ver)
         convert_cmd = None
         rsvg_convert_cmd = None
+        dot_Tpdf = False
 
         try:
             if os.environ['SPHINX_SHOW_INKSCAPE_WARN']:
@@ -216,6 +229,7 @@ def setupTools(app):
 
         if rsvg_convert_cmd:
             kernellog.verbose(app, "use rsvg-convert(1) from: " + rsvg_convert_cmd)
+            dot_Tpdf = False
         else:
             kernellog.verbose(app, "rsvg-convert(1) not found, "
                               "falling back to raster image conversion")
@@ -308,11 +322,12 @@ def convert_image(img_node, translator, src_fname=None):
 
             if in_ext == '.dot':
                 kernellog.verbose(app, 'convert DOT to: {out}/' + _name)
-                if translator.builder.format == 'latex':
+                if translator.builder.format == 'latex' and not dot_Tpdf:
                     svg_fname = path.join(translator.builder.outdir, fname + '.svg')
                     ok1 = dot2format(app, src_fname, svg_fname)
                     ok2 = svg2pdf_by_rsvg(app, svg_fname, dst_fname)
                     ok = ok1 and ok2
+
                 else:
                     ok = dot2format(app, src_fname, dst_fname)
 
-- 
2.17.1


