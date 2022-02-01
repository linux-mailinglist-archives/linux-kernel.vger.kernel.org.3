Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B81A4A53AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiBAADV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiBAADU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:03:20 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B12C061714;
        Mon, 31 Jan 2022 16:03:20 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y17so13937935plg.7;
        Mon, 31 Jan 2022 16:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=byIwpZW1+792EbjDkg1ohZm56x0AtTx/j3R8ifq04Tk=;
        b=OC6g9sIwVLmpJK5a0yxAuIRC5UToV3kc0cV3/CDSPolzZvwlm7i0u4F/BQYWJAIKYE
         Zs/pyZloZpukhRmAGPFyctiWhUx418re/9SstLtuob/KwsTLtchieK3Clvxbmhlfo9wN
         yrpSMk3jlwvmGNldNjTy1zUPynWdFdzirOqVS99IUGgCxv0+vnjZ6/tPPGpJAE+sIngi
         NsnAZ2eTTD0mUmywakWyqFYe40oD6kWkyJOfeOw0XMLQVH4LEguZF/panpLPY1z+MYhF
         fsVNEF2kW/7mlRORQmDgWbtTRkxF9Cmz0tP1uqFBY78AXiakWP/DgBgfw3DCl/dP16KA
         XKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=byIwpZW1+792EbjDkg1ohZm56x0AtTx/j3R8ifq04Tk=;
        b=AAD8o7wFhsRL2ZYDbhKJKDL/Z9nUMlFTV1Aazc55qQ35jOLCCF8gOyFUvqpZ712eoi
         5MrULr7iZWXdqshqzj8HavYz6z2d4mH2wmPHNjhMjgeoE0GcVrv0hcWUkgsg2+gz7gUG
         PZFgtqMLhQfbfOcRrSaxIcfHANepX60oQd64ySImLmfN2ONHh8vkjwY59UHZLYkd2J72
         n2OX1Mka4D82uXtNVQAGPPIRaiwyoVzWJibtW+z/A95VWJyAR6TXbBGkuH0jAV1o0Aed
         tGTVVOdlPc7fbNwPRmjnGGjC8NxmOs5ju5uxeC7pweoa3/a+H0CT342g38Hv4Svc/Pgk
         fXDg==
X-Gm-Message-State: AOAM530wCMX+qY6BZbaS77oEG5HJ2vdPkVue6RHLwtspRr/RjQdpmCgs
        /ZSSyIsDP4b9kCT12dda83o=
X-Google-Smtp-Source: ABdhPJxlo7Fwv5G+tjmfuaCsgR1Yd9JiEC47kb5auZf+LV+JjbpDLX0X1G253BME1pvcwABO2aVNlw==
X-Received: by 2002:a17:902:e550:: with SMTP id n16mr22526321plf.151.1643673799610;
        Mon, 31 Jan 2022 16:03:19 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id r11sm19735446pff.81.2022.01.31.16.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 16:03:19 -0800 (PST)
Message-ID: <19141b3e-01d9-1f6d-5020-42fbda784831@gmail.com>
Date:   Tue, 1 Feb 2022 09:03:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: [PATCH 3/5] docs: pdfdocs: Enable CJKspace in TOC for Korean titles
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <b5b948b7-8e41-3bd6-1a52-44785c89c965@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <b5b948b7-8e41-3bd6-1a52-44785c89c965@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Korean (Hangul) titles in Table of Contents of translations.pdf
don't have inter-phrase spaces.

This is because the CJKspace option of xeCJK is disabled by
default.

Restore the spaces by enabling the option at the beginning of every
document and disable it in the \kerneldocBegin{SC|TC|JP} commands.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/conf.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index e70aa5fd969f..ded49b8e9bf6 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -520,6 +520,7 @@ latex_elements['preamble']  += '''
 	    \\renewcommand{\\CJKrmdefault}{SCserif}%
 	    \\renewcommand{\\CJKsfdefault}{SCsans}%
 	    \\renewcommand{\\CJKttdefault}{SCmono}%
+	    \\xeCJKsetup{CJKspace = false}%
 	}
 	\\newcommand{\\kerneldocEndSC}{\\endgroup}
 	\\newcommand{\\kerneldocBeginTC}{%
@@ -530,6 +531,7 @@ latex_elements['preamble']  += '''
 	    \\renewcommand{\\CJKrmdefault}{TCserif}%
 	    \\renewcommand{\\CJKsfdefault}{TCsans}%
 	    \\renewcommand{\\CJKttdefault}{TCmono}%
+	    \\xeCJKsetup{CJKspace = false}%
 	}
 	\\newcommand{\\kerneldocEndTC}{\\endgroup}
 	\\newcommand{\\kerneldocBeginKR}{%
@@ -538,7 +540,7 @@ latex_elements['preamble']  += '''
 	    \\renewcommand{\\CJKrmdefault}{KRserif}%
 	    \\renewcommand{\\CJKsfdefault}{KRsans}%
 	    \\renewcommand{\\CJKttdefault}{KRmono}%
-	    \\xeCJKsetup{CJKspace = true} % For inter-phrase space
+	    % \\xeCJKsetup{CJKspace = true} % true by default
 	}
 	\\newcommand{\\kerneldocEndKR}{\\endgroup}
 	\\newcommand{\\kerneldocBeginJP}{%
@@ -547,6 +549,7 @@ latex_elements['preamble']  += '''
 	    \\renewcommand{\\CJKrmdefault}{JPserif}%
 	    \\renewcommand{\\CJKsfdefault}{JPsans}%
 	    \\renewcommand{\\CJKttdefault}{JPmono}%
+	    \\xeCJKsetup{CJKspace = false}%
 	}
 	\\newcommand{\\kerneldocEndJP}{\\endgroup}
 	% Single spacing in literal blocks
@@ -555,6 +558,7 @@ latex_elements['preamble']  += '''
 	\\usepackage{etoolbox}
 	% Inactivate CJK after tableofcontents
 	\\apptocmd{\\sphinxtableofcontents}{\\kerneldocCJKoff}{}{}
+	\\xeCJKsetup{CJKspace = true} % For inter-phrase space of Korean TOC
     }{ % No CJK font found
 	% Custom macros to on/off CJK (Dummy)
 	\\newcommand{\\kerneldocCJKon}{}
-- 
2.17.1


