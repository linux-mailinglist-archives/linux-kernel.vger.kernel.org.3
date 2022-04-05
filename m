Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C2A4F5088
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1842211AbiDFB1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457636AbiDEQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:23:06 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8F670F53;
        Tue,  5 Apr 2022 09:21:07 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35:2589:2a93:190d:b787])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 31D34608;
        Tue,  5 Apr 2022 16:21:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 31D34608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1649175667; bh=9FJqupExhv6jdwd0TZ/dWnNU37azUvwEVvEHHFmkmtk=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=l6ePVsg260vqv5CfEvstHtdOQvEpP02ZAhL3wz50QfIA1rHm7SFfL/QZ46w/XUIf8
         YNtKblkXS2AJ4wWkAVOgrRunP2sEaJ7P6dC33ihFikdKYWyo1mYoQBJEyzh5O9PbOb
         zjEcoXrOwPN6gc+LWnyXEQ/zZPuatXArODI7zt2KHq/0VMwx22gNhrOsWSbl1ATyYr
         wTEF+EzKjFio55r0y4D+DCUVVUJN5+WFI/lq49cUK6cY9RLBc6VfK8xE1yeG9PXwjW
         VAvxWVIBNpyD8+oBlkOmMqIezzanEhasf/NdMfcP/TPz1DNa37OSlq/QJlcY8mEjIo
         sgK3Rrdr/TNrw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Markus Reichl <m.reichl@fivetechno.de>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Markus Reichl <m.reichl@fivetechno.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] w1: w1_therm: Document Maxim MAX31850 thermoelement IF.
In-Reply-To: <20220321120415.27533-1-m.reichl@fivetechno.de>
References: <20220321120415.27533-1-m.reichl@fivetechno.de>
Date:   Tue, 05 Apr 2022 10:21:06 -0600
Message-ID: <87ee2bec25.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Reichl <m.reichl@fivetechno.de> writes:

> w1_therm driver supports now MAX31850, too. Add it to documentation
> and fix a small typo.
>
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> ---
>  Documentation/w1/slaves/w1_therm.rst | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied, thanks.

jon
