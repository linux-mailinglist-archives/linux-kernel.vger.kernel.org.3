Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26954C34E9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 19:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbiBXSnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 13:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiBXSnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 13:43:09 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A7C1B71BB;
        Thu, 24 Feb 2022 10:42:39 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 06C6F5BF;
        Thu, 24 Feb 2022 18:42:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 06C6F5BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645728159; bh=iHrEXGynYHjmX014drcCJSCi4ueUR7tibO28ppmKxmo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JVI/SbYxlwIsGyV+NcS5Xl/MSvG2DqMfW3ucpk//PPmefSHh81g8Ph1EaQpW0ggGY
         GBNdUHr89gZNps7mKgQxg6fRrg7MtyhrVOLTFGwM2gV15cAXaPiNPRDYeBtSVkG1RW
         W8CUYEcn8m5nIlCRJ2jiXcwqWrx5PQe85Ss7tu49vUuctO3vmq1tZ78jh84fXGXSMT
         xBLm5vyFvktMjP1RC0GVs0I7RRkNYcQkIMJ8saJc9nVFmKhbOfexMJe3xjeBiGjrRh
         y9IpLzXZfylGSRAsjJ8Iu4Ea4E3Fo63pZJAchRmB/hYSOBfZ+ARWPt7Th9f9K5t3UQ
         EBjnfbr3iENSg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Cc:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/11] Transform documentation into POD
In-Reply-To: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
References: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
Date:   Thu, 24 Feb 2022 11:42:38 -0700
Message-ID: <87tucokswx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com> writes:

> This series transforms the free-form general comments - mainly the usage
> instructions and the meta information - into the standard Perl
> documentation format. Some of the original text is reduced out. And some
> is simply dropped.
>
> The transformation includes language, paragraphing and editorial
> corrections.
>
> The only change in the script execution flow is the replacement of the
> 'usage' function with the native standard Perl 'pod2usage'.

I have applied the series, thanks.

jon
