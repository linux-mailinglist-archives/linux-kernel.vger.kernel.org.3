Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EC653752C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiE3Gn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiE3GnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:43:25 -0400
Received: from sonic315-11.consmr.mail.gq1.yahoo.com (sonic315-11.consmr.mail.gq1.yahoo.com [98.137.65.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F473B574
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1653893003; bh=r8p9jyY6bxvUUXiFW5S1xmrxidOtb2OM7NRl1Xaq38A=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=1V/khW4PrJQZsk5BUuB3OZp1v1B269fmWIjzjbDNj1vflNy5fsO9j4cF6wZIxZZyAZt3GSW4kPVokpNRSlAWIhdbGkE/2xoVTB3LA/HivKVyuQqWS3+6Jt6rjOBaA686FsMP1Sk7VRMQISAvfHM8rOD0wwG1NP9AgYkxL4AaWGY=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653893003; bh=t4Kuoy6LcJPgGwhbGE6HcHBA46oTjMB6Cbn/qaTYeP0=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fXyMl4Yd2Sap/AJBV99EQ3H110EUWtFu8x+XeY1XrqYXPv6ehd5aoyXJahrEmqbWwqfpdpRVibtMYxjgZppayR3gtevQOuQDOU3ImX5uTDs0yUbzz4C6FEr7qvefBe2BIZdEXFuw4Y872f6q6YqGXrOCBICQo+GZCSq35VLg3I98E4rOVzVNFerOzMzEAjsA4+KL+a4YuWkO7LgDAu7DQa/Necz2mHO5ZE3SKjjmxPKVItcPDj9nlM/uyp6QT6FPxhVCYENy33+vvtViQ9rnBpK8DoPh5qhu6gkzqQwZIOXCrhbg0M4BQ5EEVm3/V1dM/G7Uz/ohAQQGEHzvEABSyw==
X-YMail-OSG: _JTbnocVM1mQniKyzDuKgNJ5PiByJB5MO7cLZXjKxr348of.5f30mFZyhUooBE1
 4KlMsXhvyiZR2TDBLeam5UshtPPkSgGqa87J3RJ8XCQdZIWWJrHV67GU0T0o5Kqqefu0ppr8MURe
 vjVkufhjyPa5SniQdVtG1ZzWdFnQDmMzBJFlSsSALuHvp2G9lsUQaFSNn2yP.ouzeyx5tqzbN4Y6
 IjbWwZosT8h9zXmPpKfAagW_yXwthUtBZ7fDRN.Tk.7Jornwvz9zeGkH2lnvmvmbatozWCpw_4CA
 BhltcefBFnb71ry0QGoG2QPe8_TM3_2SPeZobOvJaJpFm67DmDE5DwbkTxcmKA523GRTbpD0w7qe
 ax.xa5Im5.XMu3HSk8bbZl8CMygdtfatbab7vXMcGvPr_gbkkORe2vNObVohCSGpyPO4M10074KX
 kFPO5SJkWFrHnu1F3rrA53KbUwKspVwmagDS6k2nVvZh8CyQLRlSwl3HzwNzQYZ0UxJnZ3uUhy5b
 joYCXbKVfc7pALubWIi4D3R_liStAHJ5gmfs2kOHqopUmp3CC4K2c71Zz_teko._PfABtAX0Rfui
 xxi_BZvn8Uv9NRB4FYu6v4XFLDjwoVJOlaVhDA3EYDvz3Ux5KblhSsjdi1Vm_WRunezL5vX6baKd
 CJWCfef7PVoDRwdU5GUZY84Pskio52T8gpEh92xWN6nh95uWnigTYmgiC_Z9UZjjJvA7eYKjlvRE
 ECK.5fddkMBX5tgyjVEWE4AeTYMrcx.xWSK_kSIx95IVcN2BnAjjVlcPfBBYpe35XbHDTuKs4Weo
 GpNhdBRiuFCSrcjhnpZIIN.VQMH2GcunM05PnCrdWqozpU8TDxEKdmKuAig9CGhmGti25N4fJ9W9
 5hEOrj0UKaTZN4ifulLYARu7PSin8.70khsrquscluTsXbnfYo3JJ2j8nVZ_.BSa6uKi6vqdYgd2
 z0_eOoekQ5wWjkVTyFzB6sJ5ruS8ZqF0WVTd5UFScvNUDbxJmuR4xYPFFVhvQSRgMbu.Va221r6s
 MMGqH7AIAnz.QBYp4tuuvhWqSVGmjenkQXuafoAEcfefKg5TE9r9Rhkcy8ZkegL9XAHpYEYv7tbg
 3XA44mB56eBW7JC1Q9Z6UAEapK9mxdpelx0yvwRRNxVDg4EQWqImVX0q4CV.9KiwIkZfLQ3T.EFA
 h7RsXelmLA5c3zevvvimwQye9K.hdOwsYQIjbBww8U2yuwdhPHMdtCkDKlfIc.8DwsojSPTLi5cj
 s63.1xoPOI0J10554s4sfVvuUfSs7d_T5FlGZtgHqYDMLV.2alXrsa.rSWUwKAMpAp.5up3hcxfx
 _PW5KMfkL_l34PXDlRiAWIOwLTfTa3a6cknzEhMEhLpJw3W8MaFyekm6dQ1Lvr5PpHzG7RIEzj_R
 QcRIvxYCX8a_JqmHslHYssYqqz2kGBPA1zVUeB6MrP1V9DLn6E7FbuIsHT4GweybNz1r5MOOmN6T
 JfGv8zrBmLX8HMu5rgAh3FvpblqKOkWz3EC7S1QB0537ykvlJRbQVgqTnjhLvlzt2j_P6an01703
 HyvDHvJ76HuDLBNM5bazEDW_Z02JWyoFyH1AhlSUE3NDp_6x6SNXo1BE.pz_4sJg0xkU99pTsjOG
 nO843HkeWIqsZNd4uE6gPocV4JyaI8ycT9OusccBpX5LrA6KP_0NlJFj9n0OJX4c5zgcMhxL6Tun
 vOlD6k_SBcGCamxNUynN5wqxi5NUnyD5FPMyyUZBiXT5b1WCWdDeQSx3GHkyb606kZotyizUlB2O
 zgHw.0BrnyI86MSts5XEaiuVC5HBAOQqWn_5q2jF70OGDyS.N2Cm4e60Yhu2z4VVksgpabnNk_SC
 NId7Uvra9_PiJ8BjVpXOesuPkazdw7CEduaX5DTkWBu3bYAERdhMk1DtngPBnpPN5ntBA6X_KgAA
 jYpEC5z0kC.9QLTGC5Dwr.fKKNZd4hiJlIT9Q7H9T2PlilSqwltFAheslC2y22NM_iA3aOtDHc.9
 4m9AshvqRTpIEUZzs_grCFx1hEDcLilMsjLdUbzy.eNhF0gJpMWl_uAcH1IowggCCUg3zIsY1ncM
 TenI8iI0YQlhWUTVHfG8DsvEXwhSLtL0gpJ2JcboKcTsl4nstPPOdOUBVt8NJ4leSPWoYnltoHa0
 xRJ6Tq.1rRpZK90f5QLOEMI0mPhqKZLX.6biAhW1n7Qhm_iRcmY9PJS_fKQ78ZL3jVPRV1Oj.dC3
 mATcDQcp0SMwvK6AUErDNB2CtkE_fFr3oGthtzOed8Q4pRDCmpYnb7hdeH85q3J8Mn1f9vw--
X-Sonic-MF: <lesrhorer@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Mon, 30 May 2022 06:43:23 +0000
Received: by hermes--canary-production-ne1-799d7bd497-rcgtf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5202819b1e19cf12b555ad4e1623d824;
          Mon, 30 May 2022 06:43:20 +0000 (UTC)
Message-ID: <5bf81aee-a518-5bc4-804c-e05db230b1c1@att.net>
Date:   Mon, 30 May 2022 01:43:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Module failure on new install of Debian Bullseye
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
References: <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0.ref@att.net>
 <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0@att.net>
 <7999b7b4-3b58-a9c4-4756-445e54404f0f@csgroup.eu>
 <ba2fb3ff-22dd-d68e-fa99-02de39240f20@infradead.org>
 <3b8f2ed6-11fd-b5a7-5442-7cac90348514@att.net>
 <8de4e4b7-f741-eb4d-9e11-9b23ba65c21a@att.net>
 <13529cf4-a00d-5e59-2e1c-cb1daf24bf71@csgroup.eu>
From:   Leslie Rhorer <lesrhorer@att.net>
In-Reply-To: <13529cf4-a00d-5e59-2e1c-cb1daf24bf71@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20225 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2022 1:08 AM, Christophe Leroy wrote:
> 
> 
> Le 30/05/2022 à 01:46, Leslie Rhorer a écrit :
>>
>>       Below is the output of dmesg after removing quite a few of what I
>> am certain are unrelated lines:
>>
>> [    0.000000] Linux version 5.10.0-13-amd64
>> (debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.1-6) 10.2.1
>> 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP Debian
>> 5.10.106-1 (2022-03-17)
> 
>> [    1.465675] bnx2x: disagrees about version of symbol module_layout
> 
>> [   12.075903] bnx2x: disagrees about version of symbol module_layout
> 
> 
> Those two messages means that you are trying to use modules that were
> built for a different kernel version.

	That is pretty clear

> 
> As far as I can see you are using kernel 5.10
> 
> You have to use bnx2 modules for that exact kernel.

	Right.  I thought of compiling them myself, but so far I have not been 
successful in loading the kernel headers.  I have tried adding a line to 
the sources.list file, but so far I haven't found a directory in the 
installation drive that apt doesn't complain about.
