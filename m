Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567B2509A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386480AbiDUIMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386464AbiDUIMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:12:24 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB4C1DA7D;
        Thu, 21 Apr 2022 01:09:35 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5FC582D7;
        Thu, 21 Apr 2022 08:09:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5FC582D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650528575; bh=5Pv2XFkNCv+/OrUz+c2muD9XTwPx9utQOZAWaseH+80=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TMn8Tq9xsV+ljsIBhf7BQ+NBRvgL96yjrOVlobZT4/LWrrUZJiyEXG3USj/QIGnjx
         iqoQvfX1sZS1dsNpG1KwamXCU9JQMiSrHEV9gjNAbK8NmXu//f6BBTetEkTU+ynExk
         SEzYGtpY4rWMYFX+RYxHUNmV/j++stHxAvcENIhwd/paOOBlZSzCw4VDyW7789NYv9
         TSW6y6OM7sXKzc+tTfvF7J+IjS0F8oq00I6h+rwN0hhHoSPfen6o8dMkyudIYlfRNs
         pPg2S+wJbx+RwPkTjspn4YMjcZArUNx6Cv8fV6EMrPktrVrmA/pFLwFhxY3VQ+72pW
         8aBzWSNVwKWOg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Bruno Moreira-Guedes <codeagain@codeagain.dev>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v2 0/2] Docs: Update information at changes.rst
In-Reply-To: <2f4c72d2-4669-4217-f322-9d4f34c3053e@gmail.com>
References: <cover.1650376049.git.codeagain@codeagain.dev>
 <8735i83xo1.fsf@meer.lwn.net> <20220420172731.ru7kfrdkmprybtu7@AN5Bruno>
 <878rrz30d9.fsf@meer.lwn.net>
 <2f4c72d2-4669-4217-f322-9d4f34c3053e@gmail.com>
Date:   Thu, 21 Apr 2022 02:09:31 -0600
Message-ID: <874k2m3lj8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 4/21/22 04:34, Jonathan Corbet wrote:
>>> Thanks, Jon! I have also been thinking whether this filename
>>> ('changes.rst') is a good description of the file contents. Do you think
>>> renaming it to something like 'requirements.rst' and updating its
>>> references would be a good patch?
>> 
>> It's best not to rename things unnecessarily, especially relatively
>> well-known files that a lot of people expect to find in a specific
>> place.  We've done a lot of renaming over the last few years, but this
>> is one I might let slide for now.
>> 
>
> Did you mean the rename will be benefical?

No, I would not do the rename at this time.

jon
