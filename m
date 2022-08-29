Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF1A5A52BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiH2RHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiH2RFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:05:36 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967356373;
        Mon, 29 Aug 2022 10:04:52 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 971832E0;
        Mon, 29 Aug 2022 17:04:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 971832E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661792691; bh=FwzTMUO8YkpbGodTNGber4FhzAcRYx2EzQJl1HJ9Yno=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ao6b32/u/EvHUvnG6dvW/UKe4ahvd95KeSq6TqzqXsyMU2lXFJek8q3blj1Vqp+eo
         UAcNTfe4H7cQxUSOVlnmT5y3MjQ3Ig7UZiNxQM85rybocg+ou3AmEM5w78NjFV/CpG
         7lt0Pxeo8+7Ffpe++RdgNCe5oMkkwAMkT3xN11VYK6bscPiUdoldUTDg9p7lX3dgak
         pN6ihOUZs2GdrICG5cZqhiHVcaaODbeqJuvc+6whuGkAy0UgPVwy203rAip8/eYsdT
         amUQAJqvHLTFJDlMxBwo1R+QzHbafn9nOOuQ2u6+qTzSJzwEmP9TfrGxNM7GIxmm8l
         stuUH3IS6uDcw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Documentation/ABI: correct possessive "its" typos
In-Reply-To: <20220801025207.29971-1-rdunlap@infradead.org>
References: <20220801025207.29971-1-rdunlap@infradead.org>
Date:   Mon, 29 Aug 2022 11:04:51 -0600
Message-ID: <875yiboua4.fsf@meer.lwn.net>
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

Randy Dunlap <rdunlap@infradead.org> writes:

> Correct all uses of "it's" that are meant to be possessive "its".
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Documentation/ABI/testing/sysfs-bus-bcma           |    2 +-
>  Documentation/ABI/testing/sysfs-bus-fcoe           |    2 +-
>  Documentation/ABI/testing/sysfs-bus-iio-proximity  |    2 +-
>  Documentation/ABI/testing/sysfs-devices-system-cpu |    2 +-
>  Documentation/ABI/testing/sysfs-power              |    2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

I stumbled across this languishing in my docs folder.  Applied, now,
thanks.

jon
