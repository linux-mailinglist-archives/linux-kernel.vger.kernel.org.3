Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1F94C786E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiB1TCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiB1TCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:02:21 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F8597BAA;
        Mon, 28 Feb 2022 11:01:41 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id g6-20020a9d6486000000b005acf9a0b644so10253507otl.12;
        Mon, 28 Feb 2022 11:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=Yu5GvhbEsk789CJlMzPewAkr+uhHwTdnW83yCtz5yB0=;
        b=Yeu7t+2Nn3oIF9A3lF6FQNItl/KBCrtUfqzEDq2cv9/+YH5g4uTnyJUzgwEjWSPCUu
         cXh8hOL0KnBQkzGXKc5+wj2RfNq5WKPXR0gXVRk88VlTK6SXf3l8CYmcagYTD8HZDA7D
         FWfXH98jObIRVCPvTtwrhAMRdAyEiS44d9tpi9giMErS0jVK90iZlZR7bEI4jpyofIMJ
         /FOy1YzYSHHdEcSpylOP22bd4XJ2la71X8fskZG9kqfr5oxE7UoVyNjajo8EzKgi8x0i
         Z/utu4nvPT/V3dHy2IPTkJQ9vrLpeR07yk+naDluqKFJnJe/gL/RUXnR820gLZlFDQOW
         RUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Yu5GvhbEsk789CJlMzPewAkr+uhHwTdnW83yCtz5yB0=;
        b=LrbjMkMO/wyRoBQWgKXg5BbCa7pv7vubl4RV8EKuqcNRa5x+Xe2nzoKxkUlgmUSiLX
         f8wmTwuQH3NbvK7bzepD3ibHFNneQvYRdQv2PHiG7KxHFLwYP363MD3PGiwhF2COAlMQ
         Cm/Fua/7so187DhqdmWtIXtgthq4JkkNKUSinNLmWxhYY4MUu2qiNxSdMDo0rLa9GFHs
         C47jV/uUYuVrK1omgKgyf6NVe/hUYx0/O5zwS7q8bBxF3LR1k+3+vWvKGj+Ebs3FNBKh
         6ixSTqf3rzx9AvofL45gWWLCh0y0Hz2/C5fzRwsWDsFWUnI0mE6m0G9BM4zu5GGgZ6Kf
         WSvA==
X-Gm-Message-State: AOAM533a0kKPq1Z6N8Ade7mb0Azc3XaWcU2oEsHwDTYm42XSlWtNLbra
        zYyMHmvgszupnx5dsamfsHTttqLwQXg=
X-Google-Smtp-Source: ABdhPJxl4wXuLxf6hKq1W09PAy/T4OJO24Ao1mp8Fr4RZqiJFOxx4jBxo2FXW48fCtiIMzfqdYxUgw==
X-Received: by 2002:a9d:7596:0:b0:5af:1779:5dc8 with SMTP id s22-20020a9d7596000000b005af17795dc8mr10152417otk.285.1646074901134;
        Mon, 28 Feb 2022 11:01:41 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:ed66:faaa:6559:18c7? ([2600:1700:2442:6db0:ed66:faaa:6559:18c7])
        by smtp.gmail.com with ESMTPSA id fo25-20020a0568709a1900b000d441d5fdc5sm5085748oab.9.2022.02.28.11.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 11:01:40 -0800 (PST)
Message-ID: <3c56d148-1133-9371-330b-b2dd56846961@gmail.com>
Date:   Mon, 28 Feb 2022 13:01:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] of: unittest: add program to process EXPECT messages
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220201181413.2719955-1-frowand.list@gmail.com>
In-Reply-To: <20220201181413.2719955-1-frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Ping.

-Frank

On 2/1/22 12:14, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> If unittest detects a problem it will print a warning or error message
> to the console.  Unittest also triggers warning and error messages from
> other kernel code as a result of intentionally bad unittest data.  This
> has led to confusion as to whether the triggered messages are an
> expected result of a test or whether there is a real problem that is
> independent of unittest.
> 
> EXPECT messages were added to unittest to report each triggered message
> that is expected, resulting in verbose console output.
> 
> scripts/dtc/of_unittest is a new program that processes the EXPECT
> messages to determine whether the triggered messages occurred and
> also removes the excess verbosity of the EXPECT messages.  More
> information is available from 'scripts/dtc/of_unittest_expect --help'.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> permissions for scripts/dtc/of_unittest should be 770
> 
> I will reply to this message with the usage message from
> 'scripts/dtc/of_unittest_expect --help'.
> 
> I will also reply with examples of raw and processed console logs.
> 
>  Documentation/devicetree/of_unittest.rst |  27 +-
>  scripts/dtc/of_unittest_expect           | 408 +++++++++++++++++++++++
>  2 files changed, 432 insertions(+), 3 deletions(-)
>  create mode 100755 scripts/dtc/of_unittest_expect
> 
> diff --git a/Documentation/devicetree/of_unittest.rst b/Documentation/devicetree/of_unittest.rst
> index 2afe41a37148..8864b52d1195 100644
> --- a/Documentation/devicetree/of_unittest.rst
> +++ b/Documentation/devicetree/of_unittest.rst
> @@ -24,7 +24,28 @@ from the unflattened device tree data structure. This interface is used by
>  most of the device drivers in various use cases.
>  
>  
> -2. Test-data
> +2. Verbose Output (EXPECT)
> +==========================
> +
> +If unittest detects a problem it will print a warning or error message to
> +the console.  Unittest also triggers warning and error messages from other
> +kernel code as a result of intentionally bad unittest data.  This has led
> +to confusion as to whether the triggered messages are an expected result
> +of a test or whether there is a real problem that is independent of unittest.
> +
> +'EXPECT \ : text' (begin) and 'EXPECT / : text' (end) messages have been
> +added to unittest to report that a warning or error is expected.  The
> +begin is printed before triggering the warning or error, and the end is
> +printed after triggering the warning or error.
> +
> +The EXPECT messages result in very noisy console messages that are difficult
> +to read.  The script scripts/dtc/of_unittest_expect was created to filter
> +this verbosity and highlight mismatches between triggered warnings and
> +errors vs expected warnings and errors.  More information is available
> +from 'scripts/dtc/of_unittest_expect --help'.
> +
> +
> +3. Test-data
>  ============
>  
>  The Device Tree Source file (drivers/of/unittest-data/testcases.dts) contains
> @@ -56,7 +77,7 @@ The assembly file is compiled into an object file (testcases.dtb.o), and is
>  linked into the kernel image.
>  
>  
> -2.1. Adding the test data
> +3.1. Adding the test data
>  -------------------------
>  
>  Un-flattened device tree structure:
> @@ -191,7 +212,7 @@ properties are updated to the live tree's node by calling the function
>  update_node_properties().
>  
>  
> -2.2. Removing the test data
> +3.2. Removing the test data
>  ---------------------------
>  
>  Once the test case execution is complete, selftest_data_remove is called in
> diff --git a/scripts/dtc/of_unittest_expect b/scripts/dtc/of_unittest_expect
> new file mode 100755
> index 000000000000..96b12d9ea606
> --- /dev/null
> +++ b/scripts/dtc/of_unittest_expect
> @@ -0,0 +1,408 @@
> +#!/usr/bin/perl
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright 2020, 2022 Sony Corporation
> +#
> +# Author: Frank Rowand
> +
> +# This program is meant to be an aid to reading the verbose output of
> +# on the console log that results from executing the Linux kernel
> +# devicetree unittest (drivers/of/unitest.c).
> +
> +$VUFX = "220201a";
> +
> +use strict 'refs';
> +use strict subs;
> +
> +use Getopt::Long;
> +use Text::Wrap;
> +
> +# strip off everything before final "/"
> +(undef, $script_name) = split(/^.*\//, $0);
> +
> +# following /usr/include/sysexits.h
> +$EX_OK=0;
> +$EX_USAGE=64;
> +
> +
> +#______________________________________________________________________________
> +sub compare {
> +	my ($expect, $got) = @_;
> +	my $expect_next;
> +	my $expect_next_lit;
> +	my $got_next;
> +	my $type;
> +
> +	while ($expect) {
> +
> +		($expect_next, $type) = split(/<</, $expect);
> +		($type) = split(/>>/, $type);
> +		$expect =~ s/^.*?>>//;	# '?' is non-greedy, minimal match
> +
> +		# literal, ignore all metacharacters when used in a regex
> +		$expect_next_lit = quotemeta($expect_next);
> +
> +		$got_next = $got;
> +		$got_next =~ s/^($expect_next_lit).*/\1/;
> +		$got       =~ s/^$expect_next_lit//;
> +
> +		if ($expect_next ne $got_next) {
> +			return 0;
> +		}
> +
> +		if ($type eq "int") {
> +			if ($got =~ /^[+-]*[0-9]+/) {
> +				$got =~ s/^[+-]*[0-9]+//;
> +			} else {
> +				return 0;
> +			}
> +		} elsif ($type eq "hex") {
> +			if ($got =~ /^(0x)*[0-9a-f]+/) {
> +				$got =~ s/^(0x)*[0-9a-f]+//;
> +			} else {
> +				return 0;
> +			}
> +		} elsif ($type eq "") {
> +			if ($expect_next ne $got_next) {
> +				return 0;
> +			} else {
> +				return 1;
> +			}
> +		} else {
> +			$internal_err++;
> +			print "** ERROR: special pattern not recognized: <<$type>>, CONSOLE_LOG line: $.\n";
> +			return 0;
> +		}
> +
> +	}
> +
> +	# should not get here
> +	$internal_err++;
> +	print "** ERROR: $script_name internal error, at end of compare(), CONSOLE_LOG line: $.\n";
> +
> +	return 0;
> +}
> +
> +
> +#______________________________________________________________________________
> +sub usage {
> +
> +# ***** when editing, be careful to not put tabs in the string printed:
> +
> +	print STDERR
> +"
> +usage:
> +
> +  $script_name CONSOLE_LOG
> +
> +     -h                print program usage
> +    --help             print program usage
> +    --hide-expect      suppress output of EXPECTed lines
> +    --line-num         report line number of CONSOLE_LOG
> +    --no-expect-stats  do not report EXPECT statistics
> +    --no-strip-ts      do not strip leading console timestamps
> +    --verbose          do not suppress EXPECT begin and end lines
> +    --version          print program version and exit
> +
> +
> +  Process a console log for EXPECTed test related messages to either
> +  highlight expected devicetree unittest related messages or suppress
> +  the messages.  Leading console timestamps will be stripped.
> +
> +  Various unittests may trigger kernel messages from outside the
> +  unittest code.  The unittest annotates that it expects the message
> +  to occur with an 'EXPECT \\ : text' (begin) before triggering the
> +  message, and an 'EXPECT / : text' (end) after triggering the message.
> +
> +  If an expected message does not occur, that will be reported.
> +
> +  For each expected message, the 'EXPECT \\ : text' (begin) and
> +  'EXPECT / : text' (end), 'text' will contain the message text.
> +
> +  If 'EXPECT \\' (begin) and 'EXPECT /' (end) lines do not contain
> +  matching 'text', that will be reported.
> +
> +  If EXPECT lines are nested, 'EXPECT /' (end) lines must be in the
> +  reverse order of the corresponding 'EXPECT \\' (begin) lines.
> +
> +  'EXPECT \\ : text' (begin) and 'EXPECT / : text' (end) lines can
> +  contain special patterns in 'text':
> +
> +     <<int>> matches: [+-]*[0-9]+
> +     <<hex>> matches: (0x)*[0-9a-f]+
> +
> +  'EXPECT \\' (begin) and 'EXPECT /' (end) lines are suppressed.
> +
> +  A prefix is added to every line of output:
> +
> +    'ok ' Line matches an enclosing EXPECT begin/end pair
> +
> +    '** ' Line reports $script_name warning or error
> +
> +    '-> ' Line reports start or end of the unittests
> +
> +    '>> ' Line reports a unittest test FAIL
> +
> +    '   ' Lines that are not otherwise prefixed
> +
> +  Issues detected in CONSOLE_LOG are reported to STDOUT, not to STDERR.
> +
> +  Known Issues:
> +
> +    --line-num causes the CONSOLE_LOG line number to be printed in 4 columns.
> +       If CONSOLE_LOG contains more than 9999 lines then more columns will be
> +       used to report the line number for lines greater than 9999 (eg for
> +       lines 10000 - 99999, 5 columns will be used).
> +";
> +
> +	return {};
> +}
> +
> +#______________________________________________________________________________
> +#______________________________________________________________________________
> +
> +if (!GetOptions(
> +	"h"               => \$help,
> +	"help"            => \$help,
> +	"hide-expect"     => \$hide_expect,
> +	"line-num"        => \$print_line_num,
> +	"no-expect-stats" => \$no_expect_stats,
> +	"no-strip-ts"     => \$no_strip_ts,
> +	"verbose"         => \$verbose,
> +	"version"         => \$version,
> +	)) {
> +	print STDERR "\n";
> +	print STDERR "ERROR processing command line options\n";
> +	print STDERR "\n";
> +	print STDERR "For help, type '$script_name --help'\n";
> +	print STDERR "\n";
> +
> +	exit $EX_OK;
> +}
> +
> +
> +if ($no_strip_ts) {
> +	$strip_ts = 1;
> +	$no_strip_ts = 0;
> +} else {
> +	$strip_ts = 0;
> +	$no_strip_ts = 1;
> +}
> +
> +
> +# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> +if ($help){
> +
> +	&usage;
> +
> +	exit $EX_OK;
> +}
> +
> +
> +# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> +
> +if ($version) {
> +	print STDERR "\n$script_name  $VUFX\n\n";
> +	print STDERR "\n";
> +
> +	exit $EX_OK;
> +}
> +
> +
> +# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> +if ($#ARGV != 0) {
> +
> +	# Limit input files to exactly one.
> +	#
> +	# 'while ($line = <ARGV>) {' in the code below supports multiple file
> +	# names on the command line, but the EXPECT statistics are reported
> +	# once for all input - it is not an expected use case to generate one
> +	# set of statistics for multiple input files.
> +
> +	print STDERR "\n";
> +	print STDERR "Required arguments: CONSOLE_LOG\n";
> +	print STDERR "\n";
> +
> +	exit $EX_USAGE;
> +}
> +
> +
> +#______________________________________________________________________________
> +
> +# Patterns to match 'EXPECT \ : ' (begin) and 'EXPECT / : ' (end)
> +#
> +# $exp_* are used as regex match patterns,
> +# so '\\\\' in $exp_begin matches a single '\'
> +# quotemeta() does not do the right thing in this case
> +#
> +# $pr_fmt is the prefix that unittest prints for every message
> +
> +$pr_fmt = "### dt-test ### ";
> +$exp_begin = "${pr_fmt}EXPECT \\\\ : ";
> +$exp_end   = "${pr_fmt}EXPECT / : ";
> +
> +
> +$line_num = "";
> +$timestamp = "";
> +
> +LINE:
> +while ($line = <ARGV>) {
> +
> +	chomp $line;
> +
> +	$prefix = "  ";  ## 2 characters
> +
> +
> +	if ($strip_ts) {
> +
> +		$timestamp = $line;
> +
> +		if ($timestamp =~ /^\[\s*[0-9]+\.[0-9]*\] /) {
> +			($timestamp, $null) = split(/]/, $line);
> +			$timestamp = $timestamp . "] ";
> +
> +		} else {
> +			$timestamp = "";
> +		}
> +	}
> +
> +	$line =~ s/^\[\s*[0-9]+\.[0-9]*\] //;
> +
> +
> +	# -----  find EXPECT begin
> +
> +	if ($line =~ /^\s*$exp_begin/) {
> +		$data = $line;
> +		$data =~ s/^\s*$exp_begin//;
> +		push @begin, $data;
> +
> +		if ($verbose) {
> +			if ($print_line_num) {
> +				$line_num = sprintf("%4s ", $.);
> +			}
> +			printf "%s %s%s%s\n", $prefix, $line_num,  $timestamp, $line;
> +		}
> +
> +		next LINE;
> +	}
> +
> +
> +	# -----  find EXPECT end
> +
> +	if ($line =~ /^\s*$exp_end/) {
> +		$data = $line;
> +		$data =~ s/^\s*$exp_end//;
> +
> +		if ($verbose) {
> +			if ($print_line_num) {
> +				$line_num = sprintf("%4s ", $.);
> +			}
> +			printf "%s %s%s%s\n", $prefix, $line_num,  $timestamp, $line;
> +		}
> +
> +		$found = 0;
> +		$no_begin = 0;
> +		if (@found_or_begin > 0) {
> +			$begin = pop @found_or_begin;
> +			if (compare($data, $begin)) {
> +				$found = 1;
> +			}
> +		} elsif (@begin > 0) {
> +			$begin = pop @begin;
> +		} else {
> +			$no_begin = 1;
> +		}
> +
> +		if ($no_begin) {
> +
> +			$expect_missing_begin++;
> +			print "** ERROR: EXPECT end without any EXPECT begin:\n";
> +			print "       end ---> $line\n";
> +
> +		} elsif (! $found) {
> +
> +			if ($print_line_num) {
> +				$line_num = sprintf("%4s ", $.);
> +			}
> +
> +			$expect_not_found++;
> +			printf "** %s%s$script_name WARNING - not found ---> %s\n",
> +					$line_num,  $timestamp, $data;
> +
> +		} elsif (! compare($data, $begin)) {
> +
> +			$expect_missing_end++;
> +			print "** ERROR: EXPECT end does not match EXPECT begin:\n";
> +			print "       begin -> $begin\n";
> +			print "       end ---> $line\n";
> +
> +		} else {
> +
> +			$expect_found++;
> +
> +		}
> +
> +		next LINE;
> +	}
> +
> +
> +	# -----  not an EXPECT line
> +
> +	if (($line =~ /^${pr_fmt}start of unittest - you will see error messages$/) ||
> +	    ($line =~ /^${pr_fmt}end of unittest - [0-9]+ passed, [0-9]+ failed$/ )   ) {
> +		$prefix = "->"; # 2 characters
> +	} elsif ($line =~ /^${pr_fmt}FAIL /) {
> +		$unittest_fail++;
> +		$prefix = ">>"; # 2 characters
> +	}
> +
> +	$found = 0;
> +	foreach $begin (@begin) {
> +		if (compare($begin, $line)) {
> +			$found = 1;
> +			last;
> +		}
> +	}
> +
> +	if ($found) {
> +		$begin = shift @begin;
> +		while (! compare($begin, $line)) {
> +			push @found_or_begin, $begin;
> +			$begin = shift @begin;
> +		}
> +		push @found_or_begin, $line;
> +
> +		if ($hide_expect) {
> +			$suppress_line = 1;
> +			next LINE;
> +		}
> +		$prefix = "ok"; # 2 characters
> +	}
> +
> +
> +	if ($print_line_num) {
> +		$line_num = sprintf("%4s ", $.);
> +	}
> +
> +	printf "%s %s%s%s\n", $prefix, $line_num,  $timestamp, $line;
> +}
> +
> +if (! $no_expect_stats) {
> +	print  "\n";
> +	print  "** EXPECT statistics:\n";
> +	print  "**\n";
> +	printf "**   EXPECT found          : %4i\n", $expect_found;
> +	printf "**   EXPECT not found      : %4i\n", $expect_not_found;
> +	printf "**   missing EXPECT begin  : %4i\n", $expect_missing_begin;
> +	printf "**   missing EXPECT end    : %4i\n", $expect_missing_end;
> +	printf "**   unittest FAIL         : %4i\n", $unittest_fail;
> +	printf "**   internal error        : %4i\n", $internal_err;
> +}
> +
> +if (@begin) {
> +	print "** ERROR: EXPECT begin without any EXPECT end:\n";
> +	print "          This list may be misleading.\n";
> +	foreach $begin (@begin) {
> +		print "       begin ---> $begin\n";
> +	}
> +}

