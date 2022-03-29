Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9FC4EAF6E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbiC2OnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiC2OnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:43:20 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1156F33A10;
        Tue, 29 Mar 2022 07:41:36 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 9299DC800A7;
        Tue, 29 Mar 2022 16:41:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id RKTB3nxXVfKn; Tue, 29 Mar 2022 16:41:35 +0200 (CEST)
Received: from [192.168.178.30] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 23110C8008A;
        Tue, 29 Mar 2022 16:41:35 +0200 (CEST)
Message-ID: <139e98e1-5405-6df7-17c3-a3accc5e8de0@tuxedocomputers.com>
Date:   Tue, 29 Mar 2022 16:41:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5] input/i8042: Rework quirk tables
Content-Language: en-US
To:     dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, hdegoede@redhat.com, samuel@cavoj.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220329143622.31394-1-wse@tuxedocomputers.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20220329143622.31394-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 29.03.22 um 16:36 schrieb Werner Sembach:
> Revision 5 with some fixes based on feedback by Hans de Goede.
>
> The 1st patch is minor housekeeping.
>
> The 2nd patch merges the tables together. Minor fixes in 5th revision and
> no more duplication of ASUS devices
>
> The 3rd patch add optional debug output to see which quirks get applied. In
> 5th revision this no longer breaks compilation on non x86 platforms.
>
> The 4th patch adds a list of Clevo devices that need multiple quirks.
> With the reworked table they don't need to be inserted multiple times now,
> which was required in v1 and v2 of this patch.
>
> I also included the extra quirk for the Clevo NS7xMU, which was a separate
> patch before.
>
> The added Clevo devices are now only identified by their board name as this
> is the only somewhat reliable string that might not be changed by resellers.
>
>
By accident I sent this patchset except the first patch tagged with v4 also. Just want to add this to avoid confusion
and sorry for the spam.

(For some reason selecting 'n' in git send-email only discards the first mail and does not ask for following patches ...
I have to check my git settings)


