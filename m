Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFC947E9B3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 00:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245111AbhLWXsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 18:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244950AbhLWXsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 18:48:54 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8A3C061401;
        Thu, 23 Dec 2021 15:48:53 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9F0046A2;
        Thu, 23 Dec 2021 23:48:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9F0046A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1640303333; bh=J6zvLXe0T7HHuahURc7GL9EPOB0ELgjkdEIvqFMmgi4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ANSwa6Y1gtolaDBx2h5BXiwezmWzxw/moV/+1hkU+Fhzs7c/dusDpIo5vltNan9L/
         6s3uasJ1tddLme+QCc4DUyliy3lE6Ek/0ihXSvlKYEwGaHFIxbjwlnPaYgfrCYZnCa
         fpipKToxaw1tZRW3uqGrHquM7UBCI2uhDcx91YaoX30N0bGVnWWH7OE0m9GMqmeanm
         KldCyz8KXuqslJrrtUqk1UdQ1JCQwQFSECzXY422pqE+/y2HJUXtK4kY3KU2vQi1kS
         +itV7npzcUpHjlsThOxMoe3C+q4CpNsO2gUCJpmCr5Zyd/9okfwmh/PgW8ug3uQEuj
         2lS4unCVoOAkg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] docs: sphinx/kfigure.py: Improve conversion to PDF
In-Reply-To: <38207705-f72a-8d79-caf9-d995bcd2a883@gmail.com>
References: <de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com>
 <87r1a3drhz.fsf@meer.lwn.net>
 <38207705-f72a-8d79-caf9-d995bcd2a883@gmail.com>
Date:   Thu, 23 Dec 2021 16:48:53 -0700
Message-ID: <87wnjudgre.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> On Thu, 23 Dec 2021 12:56:56 -0700, Jonathan Corbet wrote:
>> Akira Yokosawa <akiyks@gmail.com> writes:
>> 
>>> This patch set improves conversions of DOT -> PDF and SVG -> PDF
>>> for PDF docs.
>>>
>>> * DOT -> PDF conversion
>> 
>> So I'm unclear on the status of these patches; Mauro, are you happy with
>> them?  If so I'd like to get them in before the merge window.
>
> Jon, whether Mauro is happy or not, I want to do a respin of this and
> at least fix the typo in PATCH 5/3 Randy pointed out.
> Maybe merge PATCH 5/3 with PATCH 3/3 as well. 
>
> There is no reason to hurry, I suppose.
>
> I was kind of distracted by a development in other project lately.

No worries, I can wait :)

Thanks,

jon
