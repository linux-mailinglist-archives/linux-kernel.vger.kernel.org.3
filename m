Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D3749B8AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350833AbiAYQcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:32:47 -0500
Received: from relay033.a.hostedemail.com ([64.99.140.33]:55028 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230339AbiAYQ1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:27:08 -0500
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id B343B20B49;
        Tue, 25 Jan 2022 16:27:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: andy.pont@sdcsystems.com) by omf03.hostedemail.com (Postfix) with ESMTPA id AC9B460018;
        Tue, 25 Jan 2022 16:26:46 +0000 (UTC)
From:   "Andy Pont" <andy.pont@sdcsystems.com>
To:     "Mika Westerberg" <mika.westerberg@linux.intel.com>
Subject: Re: mfd/intel_pmc_bxt: `intel_pmc_get_resources()` results in page fault
Cc:     "Paul Menzel" <pmenzel@molgen.mpg.de>,
        "Zha Qipeng" <qipeng.zha@intel.com>, linux-kernel@vger.kernel.org
Date:   Tue, 25 Jan 2022 16:27:02 +0000
Message-Id: <em1f48e0b2-2380-45ef-a0c1-2c38a477aa5f@andys-imac.local>
In-Reply-To: <YfAbBIxDvfIYrgPV@lahna>
References: <92c233bc-d1e0-b180-efaa-27e05fbd732b@molgen.mpg.de> <YfAIrkJaahKpCta6@lahna>
 <2ebf7968-a324-6f98-e178-45d4d19cfb48@molgen.mpg.de>
 <em755e7a07-2a6b-4b3a-9bc8-5f28857392dc@andys-imac.local>
 <YfAbBIxDvfIYrgPV@lahna>
Reply-To: "Andy Pont" <andy.pont@sdcsystems.com>
User-Agent: eM_Client/9.0.213.0
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 15t61ni5si7pduk38muar4jwqczjnbfg
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: AC9B460018
X-Spam-Status: No, score=0.51
X-Session-Marker: 616E64792E706F6E744073646373797374656D732E636F6D
X-Session-ID: U2FsdGVkX18hczRln8ubIo+oUHgPCEJuuK9LKYzx7qA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdcsystems.com; h=from:to:subject:cc:date:message-id:in-reply-to:references:reply-to:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=9wmjJINB3StJwRzo6DcJFOmElYCYvCyrAov+YYo/AOw=; b=UoBgL1uDNyxFzn92lVOiaQKjNVNMx0sxZ6BDUIkhJHE0XNRxCtyp7/Q7ZFTjgvx9ZAv7f2lQildKXjRcuocVhG3JPJUiFdbwMUyGLe6IQiijA/tBB/IyFxm6f6xlTf8qAHWhyP27f+V22qNK0j7tthYnc/pfltJqu7uJOJrwsX/KoHjUiy2fwB//3zH+lu0Qr80k1sJeRXK2gGzNcPATieinwf3ACZxqAb2B61MJxxbNdl5kUQoLUayh4QOBn8eViMmQ2JWwBfTGOqerUpy3HHpSsSAiD68hPD6WMTjXd4S9sk5UTq8GtkeFeAqfiEyolCSHje7yT8xUFxu5MF5KzQ==
X-HE-Tag: 1643128006-412409
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mika,=0A=0A>Thanks! The dump looks OK to me wrt. the PMC device. Howe=
ver, I think I=0A>found the bug.=0A>=0A>Can you try if the below hack fixes =
the issue?=0AI=E2=80=99ll give the patch a test and let you know how I get =
on.=0A=0AWhich fields within the ACPI dump are you looking at?  When we bo=
ot the =0Asame hardware platform / Ubuntu image with the stock AMI BIOS the=
n we =0Adon=E2=80=99t see the kernel oops.=0A=0A-Andy.=0A

