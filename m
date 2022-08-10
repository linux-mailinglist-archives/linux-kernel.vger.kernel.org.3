Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B3F58F008
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiHJQEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbiHJQD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:03:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8493E6580A;
        Wed, 10 Aug 2022 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ATWjZwDzLd1FXTxu36i7ECb5X4VhABeeCLXPqvahL08=;
        t=1660147436; x=1661357036; b=ppqE0xXY3EffjWZqBNoU7T+g3g2T3n+8KYzJUWL1sNQ95fZ
        PyDvuRaDFLmTKwfE9SaObb5OKip1oJdYKUOB0p5uvavnXLAyuZFrvc8NQW60zAQnqPJzkpXJwzLOV
        OVqgRL22ZSmKoZ1uHX8ic6OjZb33gsBtpKlPq9wXV3wcfgYF9RUhm1i0Nk4mh7EQGKAHQXSTGpnHT
        65Pr/DOSpR0kldRuztn1lpGQRCK1sSWLAlFQ6czIuH/3Lom2ILKGRxRyQGrqGJ/7cVg1NU+FocXZ6
        KiB0/zdNbGTF0zMJi+P1PtT+mjkjmZ3YhLNtRkrgsYMWwokh+cixq/7/zZrGKzWg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oLoBH-004F4D-0T;
        Wed, 10 Aug 2022 18:03:39 +0200
Message-ID: <bfc5f964d8dadd6378f2da5b3b6ef4bc9fb847c2.camel@sipsolutions.net>
Subject: Re: [PATCH v5 1/5] sysfs: Add attribute info for
 /sys/devices/.../coredump_disabled
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Manish Mandlik <mmandlik@google.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-bluetooth@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Won Chung <wonchung@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 10 Aug 2022 18:03:37 +0200
In-Reply-To: <20220810085753.v5.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
References: <20220810085753.v5.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-10 at 09:00 -0700, Manish Mandlik wrote:
> This patch adds the specification for /sys/devices/.../coredump_disabled
> attribute which allows the userspace to enable/disable devcoredump for a
> particular device and drivers can use it to enable/disable functionality
> accordingly. It is available when the CONFIG_DEV_COREDUMP is enabled and
> driver has implemented the .coredump() callback.
>=20

It would be nice to say _why_? What problem does this solve? You could
just create the dump and discard it, instead, for example?

johannes
