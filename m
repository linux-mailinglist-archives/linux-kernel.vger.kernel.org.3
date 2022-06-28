Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A842055E971
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346459AbiF1OZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346419AbiF1OZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:25:21 -0400
X-Greylist: delayed 595 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Jun 2022 07:25:19 PDT
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1F12F01D;
        Tue, 28 Jun 2022 07:25:19 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id F0048C80101;
        Tue, 28 Jun 2022 16:15:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id uQ80GkUfP925; Tue, 28 Jun 2022 16:15:21 +0200 (CEST)
Received: from [192.168.176.132] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 29356C800FF;
        Tue, 28 Jun 2022 16:15:21 +0200 (CEST)
Message-ID: <c9eae62f-7220-a7f0-635e-e9880d49b218@tuxedocomputers.com>
Date:   Tue, 28 Jun 2022 16:15:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5] input/i8042: Rework quirk tables
Content-Language: en-US
To:     dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, hdegoede@redhat.com, samuel@cavoj.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220329143622.31394-1-wse@tuxedocomputers.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20220329143622.31394-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 16:36, Werner Sembach wrote:
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
Just a friendly reminder. Is there any update on this?

Kind regards,

Werner Sembach

