Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66802467049
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 03:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378289AbhLCCxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 21:53:54 -0500
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:41594 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243536AbhLCCxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 21:53:54 -0500
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 45C6D1815C4CB;
        Fri,  3 Dec 2021 02:50:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id A7C1C20038;
        Fri,  3 Dec 2021 02:50:28 +0000 (UTC)
Message-ID: <10e59e850894524d34cc7d89c126ab9133e6a1a7.camel@perches.com>
Subject: Re: [RFC Patch v2 1/3] i2c debug counters as sysfs attributes
From:   Joe Perches <joe@perches.com>
To:     Sui Chen <suichen@google.com>, linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        joel@jms.id.au, andrew@aj.id.au, tali.perry1@gmail.com,
        benjaminfair@google.com, krellan@google.com
Date:   Thu, 02 Dec 2021 18:50:27 -0800
In-Reply-To: <20211203023728.3699610-2-suichen@google.com>
References: <20211203023728.3699610-1-suichen@google.com>
         <20211203023728.3699610-2-suichen@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A7C1C20038
X-Spam-Status: No, score=-3.21
X-Stat-Signature: ywct6uirwhdagy39zibat4wycbdx5x6u
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19jdsD/Pinoi7TG5JJ2y9H0VAQekIuvdUA=
X-HE-Tag: 1638499828-864565
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-02 at 18:37 -0800, Sui Chen wrote:
> This change adds a few example I2C debug counters as sysfs attributes:
> - ber_cnt (bus error count)
> - nack_cnt (NACK count)
> - rec_fail_cnt, rec_succ_cnt (recovery failure/success count)
> - timeout_cnt (timeout count)
> - i2c_speed (bus frequency)
> - tx_complete_cnt (transaction completed, including both as an initiator
>   and as a target)
> 
> The function i2c_adapter_create_stats_folder creates a stats directory
> in the device's sysfs directory to hold the debug counters. The platform
> drivers are responsible for instantiating the counters in the stats
> directory if applicable.

Please try to use scripts/checkpatch.pl on your patches and see if
you should be more 'typical kernel style' compliant.

Ideally, use the --strict option too.

