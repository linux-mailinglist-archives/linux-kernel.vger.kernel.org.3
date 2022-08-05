Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C2E58A814
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbiHEIdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiHEIdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:33:13 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D6317A8D;
        Fri,  5 Aug 2022 01:33:11 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.248.80]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MiMIY-1noNQQ3Cpa-00fUnp; Fri, 05 Aug 2022 10:32:52 +0200
Message-ID: <0765e37c-be81-33dc-b4a0-8a5786417eb6@i2se.com>
Date:   Fri, 5 Aug 2022 10:32:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] clk: bcm: rpi: Fix error handling of
 raspberrypi_fw_get_rate
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220625083643.4012-1-stefan.wahren@i2se.com>
 <7656fa2c-590a-8f0f-03ef-904e4f186c82@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <7656fa2c-590a-8f0f-03ef-904e4f186c82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9tIwb1WMqV0HI9ScyE0x2HNCwM17U7bJfxCSa2ZpgAd8xf+5Z98
 CKUrSBtzs81T86+DAQCEX5OlqKQ06XCUAm58ygmooM5OEilfp/pCfw6excuMTvCvLhSpBIl
 bTZlZdcLXDNAcyCSVfa1bo66s40hFgybZDtVleYXElL+XDWtiqz/fftQRBkioKMG3xskzlD
 lzbu9TKJXgBEA5mmH/FIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eIV8A6KxsVk=:+nACvjnCObJpAqBC5JvhIZ
 RONq6siekC9FC11WsIK/yB1Jtbeh7jT0LxXFQyRasTbyJV2bnW/ARzYu6cq+VpOOKeq+nT/oa
 8edxrAEGgSBijxlCmWz00uZKkpB0YBDNOqLxhW4UYJLz0iQeo++0HqBtrfcYWSWKwPQMo2Qej
 U6mMzPAOAWk6j0+fot8Q7CBe+Cd9D1Ej7UrL7ehkVcMVn+tDgneixacJ2Na89v24wi5f4t6MC
 mdTJkwuZhtjXvY81VhA+X/8FsRZA9PqT5rjNACBQ8U/BWwxV+fW72UQ2MXfWIwO7c8dKRXnAX
 FYvPZ99VaDPODZ3DeG+mFiGlmTz8q8qqB8iu6qK2wb83q9t/3NBViGGhzhf7K7FEGO8ecJQC2
 tpyCo+lTm2k1gj8onvfNBy+dn8yY1/0BeEzTT2Z1t8vnOf5WCS4Meb1kjl1wGHt/rojj2xSf6
 NePocnoqSicDsbmEFdsy5iUTZlWZ1euOmnSJfOLCSXemA6DKYq0YghWpYAuBnBEyZ3G4v5sci
 z22K5hfOjr73ZFVheD/1wTb9Kzu6IS7uuVq+V0euEagIwQ8FSGd4PVAYJXEMRwpKAai7+Tlk1
 a+N8/EoPWhhaxS/0dyUDUvRXg+vyBjGWXqDUirAeZC/AFmQSQ87xyw5Uz7/+z32C4469vQkG+
 p6/kxpA/aP2EpA69s5NUpttii5vDCOuEJtLmcG4WMQdfxSlXO6Ll8ey3hZVGrenvTi6nA4e/S
 6qqfvI/qc9Yi0rnvOqZfno+h0hxR6DDWQnzghg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 27.06.22 um 18:24 schrieb Florian Fainelli:
> On 6/25/22 01:36, Stefan Wahren wrote:
>> The function raspberrypi_fw_get_rate (e.g. used for the recalc_rate
>> hook) can fail to get the clock rate from the firmware. In this case
>> we cannot return a signed error value, which would be casted to
>> unsigned long. Fix this by returning 0 instead.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>
> Fixes: 4e85e535e6cc ("clk: bcm283x: add driver interfacing with 
> Raspberry Pi's firmware")
>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

gentle ping

