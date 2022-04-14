Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A481D501808
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241749AbiDNQAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349191AbiDNPkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:40:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF00C55AC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649949544;
        bh=SO1sJVRdpuCi5JfeCGZQStJZ9U6nYFQpITMXggWuDTI=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=dmQUajujhJGiCL8Ak7oSDMLr38kBW7/NgzQ1noQPx1i6xfITChzk2cWw/NzKl+Fu5
         ufyhmscUgtgJ0FB+NdQemxxG3DUxjkQN2cxrP7WuvnkMY9YexaWVImsWnxcYe4CSAF
         jt1/PK0U/iYHJHj4mtWwFfc1CW3xJxOGQHNN5Nmg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.146] ([37.201.198.107]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VD8-1nzVnm1iYM-016yvL for
 <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:19:04 +0200
Message-ID: <4597be87-3a8e-1b62-9fd9-a88213b1fbd9@gmx.net>
Date:   Thu, 14 Apr 2022 17:19:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
To:     linux-kernel@vger.kernel.org
From:   "peter.boettcher.gmx.net" <peter.boettcher@gmx.net>
Subject: software execution restriction
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o6mUI06fhIzNtlxtrMQJwf+qm7bEdh/u5W3t0w6PN0Gt99lFh5U
 +QKhwXagkT1CXs7BG+UJ7N0IF8tP6nTLHLjyljA9665OjEEYAvBJiBKIk5sxv8QAxT9YUcK
 Q7PEi9QWPRucsItz8R7zXLEFxsGYj3YVz0gM3Kr7rUzwTxMkfs44j/ec7oZP9OBtXNHOj2o
 sUJyVBH4V0TiBFT2MjTWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lFurYPSYnBs=:qbXlGhihQvKrUWqitUT5ia
 wwNipdBl67BdNE8v+jd5LK4eGEPzGBz9KjTlxxLs02jUUmULUJM8PgVtl9Y36GeDOuXXcok37
 XPgq9txhpDEuYhCgKosqMbZVgUoHYKnmNEVgGRbhRnclekclhsAEa0wd9Wjnn21ocsdiyTK5C
 2hMxCa79k0rqUwVU5Bf/Bazuer57F23A04uGfCYL1LilRHsyKgiOC0oCt0yN/Op9X79/rvuiX
 Bc1nN5R6U3AmyCQUgZTVtIS5Fvzs7Bw2qKIpEEi2Gj9j95BqN46PzzajLESF0b48Q08pQ9EeV
 mEZr+s1OIsn6SD8rlFVTVd49KJB8CL6u8byam6N2/jV2t/3xM5qZ5ky4Eofn9XGpDa2r5sQGU
 aXKp5SlXianCYGKw9DNFwNWih1iApIANoREFno4aKtJ0+Zh2XX+OxApzgIGD5XKMJjhv0CIw7
 al4ycFzFyweg1wlhjSf0IjHe5Wl8+qF1r46wbhyVp6Xp9rz8CZ8RmA1MZ0A8pwiApdZamui2W
 Hmz6pc0F93aJ5z/Lkp4Du7GYZdCfjNVRR/D/BbtVvcu2BFa1DnvJaaFfIr5vJO51P005Z9Nua
 L6HqvJmi5gXY24SfziKBQ4KXrHKEgw6MoIXAwMLqimnNktP7/6fmKCrUQa4YrXdb3tfgctURW
 sUsZRSCUSa6BuqhAs0ldrm5vEhuG62CeP1bL0QzWhXuRn8+lL3iMsxm6rnxp8+wcVN6EUpTHc
 Tt8E4y8xR3NVbW2Ew8tSY1bRoyvz1qAt0AIXc090TEJmQk89taYtk1CUsEocHqblq23Vd8FFk
 7/PUMtjExWBU79AzbF6inXGCCYu+m+gLenFNu7IIRgwfvxbbUDfaX6HrKOGBdl/uhp8FQQKnO
 j2cCl9IDcm0wZh0SUROmwn+QltsPT04qAPy6k5jX4oXe4RINz+g3YPSguoLk1HN1GvO0QS7v5
 8PwovIYTl9IyySCgk/JnWVRTtvAq4++6b3PWfs+U5olCaFsX8txzHFHRUD9VvY84hF5smJxZ3
 EsZTZZNQ4qXLnesZ7cd9fNGNXOVyBSnTNylbfGsx5af1+BWkNcZ+oCcmwY7pzLfT+S3ctjGhH
 vnapUz+oOUO/CM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mail: peter.boettcher@gmx.net

Hello my name is Peter Boettcher Germany/NRW.

Sorry for this english. I have an extension for the Linux kernel
written.

The functionality corresponds to the "Software Execution Restriction" in
Windows.
But USER and GROUPS are also supported.
The extension works very well without errors or problems.

You can find the code on GITHUB under /pbamr.

The extensions are available in 2 variants: with and without an
additional SYSCALL.
Sorry, but Apparmor etc. are to complicated for me.
Command and data transfer could also take place via the "PROC SYSTEM".

If the method would be suitable for the official Linux kernel, I would
adapt the code accordingly.

Peter Boettcher
