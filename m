Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0DA55E0B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiF0HCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiF0HCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:02:42 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49F65F6F;
        Mon, 27 Jun 2022 00:02:40 -0700 (PDT)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D066D1C0004;
        Mon, 27 Jun 2022 07:02:34 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1o5ilV-00Cdzm-Ni; Mon, 27 Jun 2022 09:02:33 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     santoshkumar.yadav@barco.com, peter.korsgaard@barco.com,
        hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] platform: x86: Remove duplicated include in
 barco-p50-gpio.c
References: <YriUMDJoip0Mknh3@Sauravs-MacBook-Air.local>
        <8735fr1bqh.fsf@dell.be.48ers.dk>
        <924eb8a2-a040-0632-872b-e1951c71c169@gmail.com>
Date:   Mon, 27 Jun 2022 09:02:33 +0200
In-Reply-To: <924eb8a2-a040-0632-872b-e1951c71c169@gmail.com> (Saurav
        Girepunje's message of "Mon, 27 Jun 2022 09:09:52 +0530")
Message-ID: <87y1xizj06.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Saurav" == Saurav Girepunje <saurav.girepunje@gmail.com> writes:

 > On 27/06/22 12:41 am, Peter Korsgaard wrote:
 >>>>>>> "Saurav" == Saurav Girepunje <saurav.girepunje@gmail.com> writes:
 >> 
 >> > Remove the duplicate include of linux/io.h in barco-p50-gpio.c
 >> > file.
 >> 
 >> > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
 >> 
 >> What tree is this against? The io.h include in the line just above
 >> delay.h was already removed by:
 >> 

 > I am using git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git .

staging? That seems an odd tree to make platform/x86 changes
from. Just using the mainline tree would be a better choice.

 > if it fix on another tree . Please ignore this patch.

git describe --contains 011881b80ebe773914b59905bce0f5e0ef93e7ba
v5.19-rc2~1^2~5

So it is in 5.19-rc2, released 2 weeks ago.

-- 
Bye, Peter Korsgaard
