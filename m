Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A689D48DB90
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbiAMQTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiAMQTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:19:43 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C628DC061574;
        Thu, 13 Jan 2022 08:19:43 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 68DFF2B0;
        Thu, 13 Jan 2022 16:19:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 68DFF2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1642090783; bh=3xTeg/mcRJ6jj1tM41hsqtdxji8c0oQ9bVtrSi/02NU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hMetqMN57yFlHq3sM/I40DDe/NgBItpFkdb5pO/w1DjoE5S/t6QVcFa8M2tBWNRfg
         ehzSV4K93FCH0d8/4wS6B7tv5joiChlUczjobLgmOPQ5NfYFXUFA8kg87KduhD5fME
         X2xUl4JKzhqj1zIqygiG2CZrORYbN9zqV5bEGdpSsBYTngpYrjs4gno568X1mJQ03D
         nIzHLKMiPe8znpjOhWqlO0gnDW4CJ3d4sMCudN7ZrTJflce6yHK4gY5IHUPsn0BfaH
         ibBMNw9Zxp0hsWDGJDKdKzNJDTFO8Dpf9+INB/V07udxLhi0LscQ6MeZtk69L7AybR
         MSagzJg6bWdIg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/15] Transform documentation into POD
In-Reply-To: <20220113074116.3c9883d0@fuji.fritz.box>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
 <20220113074116.3c9883d0@fuji.fritz.box>
Date:   Thu, 13 Jan 2022 09:19:57 -0700
Message-ID: <87tue7d2vm.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com> writes:

> Any news here?

Merge window is open; I'll look more closely at stuff like this toward
the end.

Thanks,

jon
