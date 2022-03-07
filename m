Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306754CFDA3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbiCGMFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiCGMFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:05:46 -0500
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch [185.70.41.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BCC35274
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:04:52 -0800 (PST)
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 4KBxwL3hdLz4xVxW
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:04:50 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="LryxRMZw"
Date:   Mon, 07 Mar 2022 12:04:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1646654685;
        bh=tNbfds0Zkrvnerg4GoIv9RquBwiaPfFEwO186o+ANJw=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=LryxRMZwm6D7W3EKoDy05BslSzojlJFrtBvmhSXqqcj0AyDvzzE2DfzIhlaoeV5Kn
         f7FW8TsqT4NZgyKyHZ6SkQv6TLHOlo1dhuK0mcnN5bVdvqBhsHmZADx2eAl2jGX3nn
         A3DSkhK4kRH+87Lrg34+0OoVd0LWom5GKUtFv50Yc4UVM4HD+E7AK8U2DDnraRxxE3
         vz5/+UV/dZb7YaFFKwXDtLqBNF0umQzQRUOt5kEbymDkrWh9EE7DvcQgfnCT+fqmo0
         jpwgOJClPIEinbTBJv6OEQKib/nQKtLvaRKR2Ud4VNFMd/RC7ICAUR0e+XCvGggl4F
         WXbjZAykL5ksw==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc:     "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Reply-To: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Subject: Do you know which version of the Linux kernel is running on the Cisco ISR C1111-4P router?
Message-ID: <AB0feU9l_r03jGQuU1pL3oQcUz6tYy2ZboVlYuDj4R34X5rzjHCQMzxqtx8Rw-e_bmV67wZdMCJRlwofm3dF-CJAxk6zAcWjxi14pEGtUJc=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.6 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: ***
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Do you know which version of the Linux kernel is running on the Ci=
sco ISR C1111-4P router?

Good day from Singapore,

Do you know which version of the Linux kernel is running on the Cisco ISR C=
1111-4P router? I saw the following lines on the console output.

Cisco IOS Software [Fuji], ISR Software (ARMV8EB_LINUX_IOSD-UNIVERSALK9_IAS=
-M), Version 16.9.5, RELEASE SOFTWARE (fc1)
Line 366: *Mar  3 03:11:12.681: %IOSXE-2-PLATFORM: R0/0: kernel: CPU3: fail=
ed to come online
Line 367: *Mar  3 03:11:12.681: %IOSXE-3-PLATFORM: R0/0: kernel: CPU3: fail=
ed in unknown state : 0x0
Line 368: *Mar  3 03:11:12.711: %IOSXE-3-PLATFORM: R0/0: kernel: coresight-=
etm4x f0f40000.etm3: ETM arch init failed

I have 417 lines of console output, but I only provide 4 lines above at the=
 momennt. If you would like to see more console output, I will provide at y=
our request.

Looking forward to your reply.

Thank you very much.

Mr. Turritopsis Dohrnii Teo En Ming, 44 years old as of 7 March 2022 Monday=
, is a TARGETED INDIVIDUAL living in Singapore. He is an IT Consultant with=
 a Systems Integrator (SI)/computer firm in Singapore. He is an IT enthusia=
st.






-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of U.S. Em=
bassy Workers

Link:

https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

***************************************************************************=
*****************

Singaporean Targeted Individual Mr. Turritopsis Dohrnii Teo En Ming's Acade=
mic Qualifications as at 14 Feb 2019 and refugee seeking attempts at the Un=
ited Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan (5 Aug 2019) a=
nd Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

Sent with ProtonMail Secure Email.
