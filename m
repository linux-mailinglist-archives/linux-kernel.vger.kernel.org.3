Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8034C4A55C3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 04:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiBAD5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 22:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbiBAD5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 22:57:48 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698B7C061714;
        Mon, 31 Jan 2022 19:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=HOJ+XBs66wcI5ls28icG9D918dA5ohWaEpYOZSIspWw=; b=a8ehZom/MsDr0dQhHe2uVXyAhU
        yuiKmDt/SK/4lCsUWjerkuDmZwvtO0/qD7MAAgTMq/RgwiBJOlOjwpOqOsU+jbNrj3wDXQ47HqvkZ
        GinyBEmHFpHmZkHORYD3DsrAUOdaIjoVurNygOgWT1a81T3Pg3c/YI4PZV0q7p/kDZXaOVn6tQ1uh
        JO1B904HyNSEXIpkbx1ZMSyrrZ7U6K7UuGNTepOzoJRx5FhOO0drKvXmGOcgDsDC9JeqwQTPKY4eq
        GKiGdH/rJWQZIUk8g37jnlHyagaNMIjCMBead9Vjl748RQcSPMBetKZv2LuDTZQBX4916etrlrBXh
        xChT+VXQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEkIZ-005j9j-3I; Tue, 01 Feb 2022 03:57:43 +0000
Message-ID: <5dde9fc9-1c66-10d3-adea-4a9f4aaf2982@infradead.org>
Date:   Mon, 31 Jan 2022 19:57:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Docs: ktap: add code-block type
Content-Language: en-US
To:     David Gow <davidgow@google.com>
Cc:     linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20220131003637.14274-1-rdunlap@infradead.org>
 <CABVgOSmGr37mf0X0BbGxUAgch7m=aqCQtdzhYN-Wq-wq70Synw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CABVgOSmGr37mf0X0BbGxUAgch7m=aqCQtdzhYN-Wq-wq70Synw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/22 17:21, David Gow wrote:
> On Mon, Jan 31, 2022 at 8:36 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Fix multiple "code-block::" warnings by adding "none" as the type of
>> code-block. Mends these warnings:
>>
>> Documentation/dev-tools/ktap.rst:71: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> Documentation/dev-tools/ktap.rst:120: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> Documentation/dev-tools/ktap.rst:126: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> Documentation/dev-tools/ktap.rst:132: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> Documentation/dev-tools/ktap.rst:139: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> Documentation/dev-tools/ktap.rst:145: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> Documentation/dev-tools/ktap.rst:195: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> Documentation/dev-tools/ktap.rst:208: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> Documentation/dev-tools/ktap.rst:238: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>>
>> Fixes: a32fa6b2e8b4 ("Documentation: dev-tools: Add KTAP specification")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Rae Moar <rmoar@google.com>
>> Cc: David Gow <davidgow@google.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> ---
> 
> Thanks. For some reason, my version of sphinx doesn't warn on these,
> so thanks for picking it up.

Yeah, I thought that there might be a version difference causing this.
cheers.

> 
> Reviewed-by: David Gow <davidgow@google.com>
> 
> Cheers,
> -- David
> 
>>  Documentation/dev-tools/ktap.rst |   18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> --- linux-next-20220128.orig/Documentation/dev-tools/ktap.rst
>> +++ linux-next-20220128/Documentation/dev-tools/ktap.rst
>> @@ -68,7 +68,7 @@ Test case result lines
>>  Test case result lines indicate the final status of a test.
>>  They are required and must have the format:
>>
>> -.. code-block::
>> +.. code-block:: none
>>
>>         <result> <number> [<description>][ # [<directive>] [<diagnostic data>]]
>>
>> @@ -117,32 +117,32 @@ separator.
>>
>>  Example result lines include:
>>
>> -.. code-block::
>> +.. code-block:: none
>>
>>         ok 1 test_case_name
>>
>>  The test "test_case_name" passed.
>>
>> -.. code-block::
>> +.. code-block:: none
>>
>>         not ok 1 test_case_name
>>
>>  The test "test_case_name" failed.
>>
>> -.. code-block::
>> +.. code-block:: none
>>
>>         ok 1 test # SKIP necessary dependency unavailable
>>
>>  The test "test" was SKIPPED with the diagnostic message "necessary dependency
>>  unavailable".
>>
>> -.. code-block::
>> +.. code-block:: none
>>
>>         not ok 1 test # TIMEOUT 30 seconds
>>
>>  The test "test" timed out, with diagnostic data "30 seconds".
>>
>> -.. code-block::
>> +.. code-block:: none
>>
>>         ok 5 check return code # rcode=0
>>
>> @@ -192,7 +192,7 @@ line and should end before the parent te
>>
>>  An example of a test with two nested subtests:
>>
>> -.. code-block::
>> +.. code-block:: none
>>
>>         KTAP version 1
>>         1..1
>> @@ -205,7 +205,7 @@ An example of a test with two nested sub
>>
>>  An example format with multiple levels of nested testing:
>>
>> -.. code-block::
>> +.. code-block:: none
>>
>>         KTAP version 1
>>         1..2
>> @@ -235,7 +235,7 @@ nested version line, uses a line of the
>>
>>  Example KTAP output
>>  --------------------
>> -.. code-block::
>> +.. code-block:: none
>>
>>         KTAP version 1
>>         1..1

-- 
~Randy
