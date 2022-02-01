Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415914A63C9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbiBAS13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbiBAS11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:27:27 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08D2C06173B;
        Tue,  1 Feb 2022 10:27:26 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id k25so10203469qtp.4;
        Tue, 01 Feb 2022 10:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4fU16CwaNXSv04OsiOZ3YMb430l73X6vlu4kJVwG20k=;
        b=KYJNmKkb4p91XXQbFqsjbRL25/Mko2MtELbhOCsWZPoJbAPJXXoBWGymf5u49D7bzD
         opUZyhYoE+d1dYl9LyUf6N91v6sid6FJRpcSIxBzuS0zCu/0TRa11IAyTKSKodN+lKdy
         5ooQJfxuXAk52C2060I+Bbmc+5K0y4+FHWoSuTqr4mTMl8p7oH+HF6wlaD54KMWnCmVE
         jzHkloOW5SPIpxHurKn8cnzwLZIGX5/uOXzmGJk60qaTIZeQKHXaElGKpTMvTDh9ZbRK
         3eHllDv/IoaaVAWtHNvyjX/OzMVJzUolXDIl1AGsnLfklHGbftnrekFmlKBmUtdJmQGK
         VfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4fU16CwaNXSv04OsiOZ3YMb430l73X6vlu4kJVwG20k=;
        b=S0CFwpDUeMnuNrxu0tnbFx87eEnWDW3UdFuIf3e79LsUUkaGNHabYmEuXPS2DW7j4C
         lpIBCWjaWJAAJYL7L81Y7g4rNqTCdkniP+dyTf8o7rI08Jm1RI4+a4zL8o9gVafLWhLs
         XiKI02RpDEgxXna19SZGJRPzfF2dwwJANRQ4OvrWPSxqcvUby37hjT/4E6QDsskbtSOL
         OJGVjIfHptgNP3HaYeTvF2zLml+TjgzXtgqqQrtyHnhbxhlT8DyhZnypRHK1BoU4bw+I
         ujQ6UTJyhQT9H8s6Z8FopxI5T4kc9AyJu2uYdMWr5zWY7IEhUV0k9X38Hee0+6Kn/Qey
         f25A==
X-Gm-Message-State: AOAM531DegDFliwww1eoRzoRoLN57M4Y8758+zTZBKTYLw5ab42jh6VR
        VExy+FaqPP/4M0K0nZK6dU4=
X-Google-Smtp-Source: ABdhPJw2N7U22+7/5sOSlB4KcU3zAXRTpYadOqzWHPeG7KXP4+sTogcCLvRoJthCH/Opo9aHr/BeHg==
X-Received: by 2002:a05:622a:40e:: with SMTP id n14mr3047058qtx.189.1643740046137;
        Tue, 01 Feb 2022 10:27:26 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id ay12sm3492549qkb.127.2022.02.01.10.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 10:27:25 -0800 (PST)
Subject: Re: [PATCH 1/1] of: unittest: add program to process EXPECT messages
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220201181413.2719955-1-frowand.list@gmail.com>
Message-ID: <3b1b29eb-5c8e-497a-1688-fa9df80dfd6e@gmail.com>
Date:   Tue, 1 Feb 2022 12:27:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220201181413.2719955-1-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 12:14 PM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 

< snip >

> I will reply to this message with the usage message from
> 'scripts/dtc/of_unittest_expect --help'.

< snip >

$ scripts/dtc/of_unittest_expect --help

usage:

  of_unittest_expect CONSOLE_LOG

     -h                print program usage
    --help             print program usage
    --hide-expect      suppress output of EXPECTed lines
    --line-num         report line number of CONSOLE_LOG
    --no-expect-stats  do not report EXPECT statistics
    --no-strip-ts      do not strip leading console timestamps
    --verbose          do not suppress EXPECT begin and end lines
    --version          print program version and exit


  Process a console log for EXPECTed test related messages to either
  highlight expected devicetree unittest related messages or suppress
  the messages.  Leading console timestamps will be stripped.

  Various unittests may trigger kernel messages from outside the
  unittest code.  The unittest annotates that it expects the message
  to occur with an 'EXPECT \ : text' (begin) before triggering the
  message, and an 'EXPECT / : text' (end) after triggering the message.

  If an expected message does not occur, that will be reported.

  For each expected message, the 'EXPECT \ : text' (begin) and
  'EXPECT / : text' (end), 'text' will contain the message text.

  If 'EXPECT \' (begin) and 'EXPECT /' (end) lines do not contain
  matching 'text', that will be reported.

  If EXPECT lines are nested, 'EXPECT /' (end) lines must be in the
  reverse order of the corresponding 'EXPECT \' (begin) lines.

  'EXPECT \ : text' (begin) and 'EXPECT / : text' (end) lines can
  contain special patterns in 'text':

     <<int>> matches: [+-]*[0-9]+
     <<hex>> matches: (0x)*[0-9a-f]+

  'EXPECT \' (begin) and 'EXPECT /' (end) lines are suppressed.

  A prefix is added to every line of output:

    'ok ' Line matches an enclosing EXPECT begin/end pair

    '** ' Line reports of_unittest_expect warning or error

    '-> ' Line reports start or end of the unittests

    '>> ' Line reports a unittest test FAIL

    '   ' Lines that are not otherwise prefixed

  Issues detected in CONSOLE_LOG are reported to STDOUT, not to STDERR.

  Known Issues:

    --line-num causes the CONSOLE_LOG line number to be printed in 4 columns.
       If CONSOLE_LOG contains more than 9999 lines then more columns will be
       used to report the line number for lines greater than 9999 (eg for
       lines 10000 - 99999, 5 columns will be used).
