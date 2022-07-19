Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7874C57A436
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiGSQcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiGSQcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:32:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5E0140C2;
        Tue, 19 Jul 2022 09:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658248330;
        bh=08NO4ajYTq7L6Yz0UzsFvyYhOxLXwbgVf0lxHpS+jts=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=c/U99IiTp9+rB2ylrMqjNdVUE/RPi6Cgih4/L2MK0cE89TrB1IEFVp1nZlkBuB2nN
         4b2dp+11yUqJBfmL7+PbVjgU0Rj9yQVq7pZkrjO8AHOjMUQeJ8vbC5sKifMQFo8uy5
         yC5xLVQ1n2MPS2Z2f6QaESY1vmTCO4109jCXT8cU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.145.26]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeMt-1o0JmE3eWh-00VeJ4; Tue, 19
 Jul 2022 18:32:09 +0200
Message-ID: <0aa365ca-a9f0-8d15-b515-adb8823f5d28@gmx.de>
Date:   Tue, 19 Jul 2022 18:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365
 dentry_free+0x100/0x128
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20220709090756.2384-1-hdanton@sina.com>
 <20220715133300.1297-1-hdanton@sina.com>
 <cff76e00-3561-4069-f5c7-26d3de4da3c4@gmx.de>
 <20220717113634.1552-1-hdanton@sina.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220717113634.1552-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tVlPD/7xMU6x1n8XIiXM1z5w1B4tgHndptPO3FVJYI2wIcetCIx
 hU81JmqQ41EvYUhZHCWccMh5hAlSeLQ9h3NaAF2uWJ12miKk1o0q7XPV4ELpEfyb9Z1nt8y
 cgaKTMZtWQIY4WHY+KjiHY7UMcXDKnO/F8qCeEQ1PijCSPVyq21jxC/tN7tZIAQ0GGIHtwP
 /npN7a4y9ZN8nJmoP4cIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:30ovPcoxtHw=:eiMIZZ/ZPpHrMN+3I2Ug0Y
 RfjwMnovmTvp+31/DPIW0uwlVNhef5CS1X0Mh7Puhx4vgmTAzCAPFcwh0NcXu/FKpgdLNHiXY
 w3N/tA5HcpFCh+F+76L+VZyMB2la2yPlE1TXudYQFUzGM6rd7dfQ2ZlCOFyYPpGd9RpEtdjgx
 ismaflT5iI+MZMDML6THWII3YfU2PNRLI9ghoUvj1IMRT/xK0Bwk3Pju60z9M0uwrxU/n2BD+
 TXZ00J8AanZJqdQM0vhkH6CMSmV6PaPY7Zd6QRhhuJeTbbzBYNSzNk/hAuXC7tx81mc8230DP
 W1Sx4t5K3iuXHiJqA9q+Nv8KNQstB5c3//WWaNvCoYDX/AjxMkMZtJ0ScVQvZwvxLPA7o8bOQ
 wEA2uihaO1ixQeRd2OkWYB5wvXX+LmmzGG5nEcA8c9R8WjoNgzG5IpUEfGsQbv1xixjA/4Izs
 a/AnAzoLxn5Ts3of/AZzlDm43asYgi9YfZnwnUpsGneu6RcfFKI46+nj5BEo1BoAaxzNjJVg9
 5km6pM4hW6hoSZREF5sSRkHwts3ukYYlCBsK0Tf/6UEoTy79c/6jRyR0oA6URYMymOGB/7WWV
 cWSkr9tQC/LOj31hXSMeJmQJo95ORVCBKIiIY6C58q+8lsyWBMZrGENOVt6qEX5TIS1WATK8Q
 hK0J7f5iLbe2J+wIeI0VhALFJbAg1W7/TdbuudM8dhS8iIFXbrbxEIlDuVZBkXxt8MjdLvY3d
 RFOveJ/n7CCYaRpvSudLNWSwyyf3nkQ+iyiYPGKbEzixHmBTbZIygkJUir4pHPLslI8cLTWxH
 X63+W9o7WkvpLUU6/CyBFVNkMRkE0oZRFpIxS885pp9Ev2c1nm+F6WZdmsrs23FzaOreBuYIm
 VOyWmSJVIL+5r4nxI+nuLNZqaOMQMi9bZnVilnEsKo8vghZFnWOLOpkr1Pb84c/PFrSsXKhyc
 CjosHgTpxK0QeqO16REN8WHo6X8DvB85odO+eXLggW9oad4BeE3NpPgsPawtt0Lj3rmC0huw5
 c3jViqsxnxAOLK7PjXjoudI6Li17M8Wl/xPZCb4tzO7VVcOKt55eDvwtCWz6AjpMagyynMp2Z
 EFvfECDdY34Eq3IaDC3/PLAsiX2e8g1KjXqvhPF+Ewv/oRbew2U+yrl9A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hillf,

On 7/17/22 13:36, Hillf Danton wrote:
> On Sun, 17 Jul 2022 11:42:48 +0200
>> I used WARN_ON() instead of BUG_ON().
>> With that, both triggered, first the first one, then the second one.
>> Full log is here:
>> http://dellerweb.de/testcases/minicom.dcache.crash.6-warn
>
> Given the first BUG_ON triggered, and dentry at the moment is supposed t=
o
> not be alias, see if it is still in lookup with d_lock held. That is the
> step before de-unioning d_alias with d_in_lookup_hash.
>
> On the other hand if only the second one triggered, we should track
> DCACHE_DENTRY_KILLED instead in assumption that killed dentry was
> used again after releasing d_lock surrounding the firt one.

The machine has now been up for 2 days without any issues, while it had pr=
etty
much the same load as when it was crashing earlier.
So, in summary I'd assume that your patch below fixes the issue.

I'm now rebooting the machine with a new kernel, where I just changed
	if (unlikely(d_in_lookup(dentry)))
to
	if (WARN_ON_ONCE(d_in_lookup(dentry)))
in order to see if this really triggered.

Anyway, I think your patch is good so far.
Would that be the final patch, or should I test some others?

Thanks!
Helge

>
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -605,8 +605,12 @@ static void __dentry_kill(struct dentry
>  		spin_unlock(&parent->d_lock);
>  	if (dentry->d_inode)
>  		dentry_unlink_inode(dentry);
> -	else
> +	else {
> +		if (unlikely(d_in_lookup(dentry))) {
> +			__d_lookup_done(dentry);
> +		}
>  		spin_unlock(&dentry->d_lock);
> +	}
>  	this_cpu_dec(nr_dentry);
>  	if (dentry->d_op && dentry->d_op->d_release)
>  		dentry->d_op->d_release(dentry);

