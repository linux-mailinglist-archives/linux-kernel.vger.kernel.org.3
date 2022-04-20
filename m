Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DEF50812B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244501AbiDTG34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347988AbiDTG3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:29:52 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38633A733;
        Tue, 19 Apr 2022 23:26:57 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6232A536;
        Wed, 20 Apr 2022 06:26:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6232A536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650436017; bh=f7Uz8K4B/b1GK8UbEUnANcsx3qekjRh4X7oJMY2FYTY=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=hmOAiIvMG0pAzSpQ4R/b4/b/pqbv9PllqJr9zhonE/4A7JX5F6DOdXYH5DwLL561S
         hFYODhanOqWQxA18wVy0ScYuD5zxUd1LU6LOG+nqV0+FkT9iS3hDkcwFotACIYssKz
         clfTOhltAGqisMAN0p0bRbmIXpLbhg7pPvS8b4IH8J96mnu7F9d+Ll6ZVcF4Qp7Kpa
         KnYor61TZw2Xy61gk4OuOPEOAAYI9sVT3NHV2hfyU5dYiKucibFhXXLrG6vXI4D2G8
         lEFjTLyXnUFFUEWVsR3KtQpYcO7jAgrW/Ex86dKgQ/hK/hXMvNlPNwDkzibdbmcUf7
         iFWexVBflvq6Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Bruno Moreira-Guedes <codeagain@codeagain.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v2 1/2] Docs: Add cpio requirement to changes.rst
In-Reply-To: <ed6cd79c-6a1d-8299-c90a-5f00064f18e5@gmail.com>
References: <cover.1650376049.git.codeagain@codeagain.dev>
 <16abd8eb6a5c8398a030ae5d8919d5c8e92e2af1.1650376049.git.codeagain@codeagain.dev>
 <ed6cd79c-6a1d-8299-c90a-5f00064f18e5@gmail.com>
Date:   Wed, 20 Apr 2022 00:26:53 -0600
Message-ID: <87o80w46du.fsf@meer.lwn.net>
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

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 4/19/22 21:48, Bruno Moreira-Guedes wrote:
>> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
>> index a337e8eabfe1..41a44e5f47e6 100644
>> --- a/Documentation/process/changes.rst
>> +++ b/Documentation/process/changes.rst
>> @@ -56,6 +56,7 @@ iptables               1.4.2            iptables -V
>>  openssl & libcrypto    1.0.0            openssl version
>>  bc                     1.06.95          bc --version
>>  Sphinx\ [#f1]_         1.7              sphinx-build --version
>> +cpio                   any              cpio --version
>>  ====================== ===============  ========================================
>>  
>
> You mentioned that **any** version of cpio will work, right?
> Or is there a specific minimum version?

The statement of "any" seems fairly explicit to me.  It has been a few
... decades ... since cpio has seen any sort of rapid development; do
you have any reason to think there might be a version in the wild that
would not work?

jon
