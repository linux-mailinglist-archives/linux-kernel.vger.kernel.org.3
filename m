Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3164F4A4971
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbiAaOgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:36:04 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:38673 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237401AbiAaOgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:36:02 -0500
Received: by mail-oi1-f177.google.com with SMTP id u13so10770579oie.5;
        Mon, 31 Jan 2022 06:36:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pfdI/msp2EEF60n2/W2IHw8NFo4NiQGu3x9duB2ff4c=;
        b=s2FR6X3ULD+Y7/ZDKE7Sf0FpmvTmWClm4OhRg7zskhYUET8ltH4wNh5gRgU2sxojIm
         CX6V3DLfqS+WC95tLmptCp74V2ZVJ59WPrZse8uvifQS1URbvFDJBE4DeJXvNc5T+/9I
         QfFy7CsZ2zT6IudxR5B3BUEyJ2JljkcsYtMzNyZWwnNLrcf2jX+fXUcB0jtTH5RfAj3O
         mX89EzbVRgTFAVH6Vqxc+4o6nBZjtrUYKdj1tb45T9v/5wqM4daX3B69BJBm1IWV8Y7m
         1OvwP3g4H7lU82CsQOs4DZAM5fQMdDyY8Vm9bNPM5LiyMrQRW0nm51PYLF8Iq/eg5fkI
         DwIA==
X-Gm-Message-State: AOAM530GH4sdwosgNx0P9u/Emea1SJlKzY6xdVY85UTlbiGYmKGsr76n
        edFT/LLYBsXlmHre/RWS6w==
X-Google-Smtp-Source: ABdhPJx2W9Crdo8mDtmOVEiBkmJsylVqY9X1kVrK15XfI7aPqroxmSMBNyCYnEvcu/asNcC4qWk30g==
X-Received: by 2002:a05:6808:1a0c:: with SMTP id bk12mr17821828oib.64.1643639761224;
        Mon, 31 Jan 2022 06:36:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c9sm14906025oog.43.2022.01.31.06.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 06:36:00 -0800 (PST)
Received: (nullmailer pid 243357 invoked by uid 1000);
        Mon, 31 Jan 2022 14:35:59 -0000
Date:   Mon, 31 Jan 2022 08:35:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/1] of: unittest: update text of expected warnings
Message-ID: <Yffzz0xuJ44hO1Cy@robh.at.kernel.org>
References: <20220127192643.2534941-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127192643.2534941-1-frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 13:26:43 -0600, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> The text of various warning messages triggered by unittest has
> changed.  Update the text of expected warnings to match.
> 
> The expected vs actual warnings are most easily seen by filtering
> the boot console messages with the of_unittest_expect program at
> https://github.com/frowand/dt_tools.git.  The filter prefixes
> problem lines with '***', and prefixes lines that match expected
> errors with 'ok '.  All other lines are prefixed with '   '.
> Unrelated lines have been deleted in the following examples.
> 
> The mismatch appears as:
> 
> -> ### dt-test ### start of unittest - you will see error messages
>       OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found 1
>    ** of_unittest_expect WARNING - not found ---> OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
>       OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found 1
>    ** of_unittest_expect WARNING - not found ---> OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
>       OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found 1
>    ** of_unittest_expect WARNING - not found ---> OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1
>       platform testcase-data:testcase-device2: error -ENXIO: IRQ index 0 not found
>    ** of_unittest_expect WARNING - not found ---> platform testcase-data:testcase-device2: IRQ index 0 not found
>    -> ### dt-test ### end of unittest - 254 passed, 0 failed
>    ** EXPECT statistics:
>    **
>    **   EXPECT found          :   42
>    **   EXPECT not found      :    4
> 
> With this commit applied, the mismatch is resolved:
> 
>    -> ### dt-test ### start of unittest - you will see error messages
>    ok OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found 1
>    ok OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found 1
>    ok OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found 1
>    ok platform testcase-data:testcase-device2: error -ENXIO: IRQ index 0 not found
>    -> ### dt-test ### end of unittest - 254 passed, 0 failed
>    ** EXPECT statistics:
>    **
>    **   EXPECT found          :   46
>    **   EXPECT not found      :    0
> 
> Fixes: 2043727c2882 ("driver core: platform: Make use of the helper function dev_err_probe()")
> Fixes: 94a4950a4acf ("of: base: Fix phandle argument length mismatch error message")
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/unittest.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Applied, thanks!
