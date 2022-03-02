Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96124CAF9D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243219AbiCBUVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiCBUVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:21:35 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1059DC7C2F;
        Wed,  2 Mar 2022 12:20:51 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id D6138580219;
        Wed,  2 Mar 2022 15:20:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 02 Mar 2022 15:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yotsuba.nl; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=Y4citP6qvkfZbc
        tuQIIS1b0ZdrVeMn1xNzLS9Ph5y6M=; b=McXYxw0Um2bbmAsQGXHrMFz4djRXlS
        sYZyC1zgybNbGt77JDt2wBUFrwHIa+rdAxuvAhJv6YdoQPWhgfxne8U4wmfyfj0a
        qHiHPI11EemrmivwoExE/kP8ZaXaqfExQLlRYjbDIdB7avmBvfLRV04zKew4R2aj
        1MNcMDj/l5E7CmaO0Q9HaWNYwMGhZNFuPBNxffTfCEj2HNZkzCWvZCp7GWt+L4X/
        s+yisDXz+lVHCZzV+4j4GxOQhS/eQOgMllJarHdAbpNvppWYpCyvpR09oShU5yhi
        4GY/Vx/5jQUfH8SzygAOI1qGGVBoOzn8DqhO2IZSRQamxPAQRcY4ex+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Y4citP6qvkfZbctuQIIS1b0ZdrVeMn1xNzLS9Ph5y
        6M=; b=nN9EPUmpbxLDBOJlDeG7W+HQ+XUozD8Vx+tFQKL0kqbUD/v7MAb3SgoUI
        +ocs02TWNpUSbdK5ToGcDarzjcWbZ0jiLFDGt3xTyldfxUqoJ4IuIhsDhU2tB3gH
        8WumCGr1R0p27ULuNeNYxcVLJ5HEgO/WCvoMiSLzDcE2Qdbq9UyP73uYd7freaqt
        +cNsKJbuGS7gfevPGq+5oqsAp/ilufu09XBCRgGtFvHTbaQpVJ0WKI7zxI6wPwB/
        kgJ6cBD8Y+CYIapXDbSOEqCom9t2bNyVgqK2UurrjHAw92qtI4ysqQKi+w2oH+g+
        xjV863pTdYgBPXRgNKniHlLUkvNMQ==
X-ME-Sender: <xms:n9EfYomnyCuBeNUuPw3IBlk302HW7IA8pv4B0qJvvwsVp7zGDDF4jw>
    <xme:n9EfYn2HNnPLe_MfkynHF6A0MQJG-yN0wVp-JUGzgJBIze8hoVEJk8RAWHZqn-b9x
    N9n4nD-5Laq82V2YWI>
X-ME-Received: <xmr:n9EfYmpWjlDVlYaF-M8xlhKQPVGeIDbu8O6s-KdNtJZ5WQd6Tp1nPwrbzcjR_ceDg4CZAJT7TRuCI-KGQOOtbqYoZiUolIotGaH8RRzpB-dQrKA34hX6TxXvL9U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtgedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpegtggfuhfgjfffgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeforghr
    khcuvehilhhishhsvghnuceomhgrrhhkseihohhtshhusggrrdhnlheqnecuggftrfgrth
    htvghrnhepkeffhfefhfetleejtedvueefkefgkeekjeevhfekjeehgedufeegledvudev
    vddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grrhhkseihohhtshhusggrrdhnlh
X-ME-Proxy: <xmx:n9EfYklz2QjCyKfl5ukCwbKDJb51x3ouwrovHCfjImy8jFNi3E7kUQ>
    <xmx:n9EfYm1wufObY-0Vr2Bhm9Dv44b10_a94_NDsCMkxUMtNLg-OoGytQ>
    <xmx:n9EfYrtoWQz9RBUzPB2Fdh1GJ_DFyZCX-hQD-AKN-31nmZ6HIo1rwQ>
    <xmx:n9EfYvv3wLZsHapufq9U-cFRoSNBqQiT80wdrF2xuIH8eLXSiY-ytA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Mar 2022 15:20:45 -0500 (EST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] ACPI / x86: Work around broken XSDT on Advantech
 DAC-BJ01 board
From:   Mark Cilissen <mark@yotsuba.nl>
In-Reply-To: <832a5b2e-d70c-f1a6-e377-7697b1eb7049@redhat.com>
Date:   Wed, 2 Mar 2022 21:20:42 +0100
Cc:     linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kernel test robot <lkp@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7BD8A71A-95C7-4A10-82FD-BEAAE0B0DDE9@yotsuba.nl>
References: <20220302040800.10355-1-mark@yotsuba.nl>
 <832a5b2e-d70c-f1a6-e377-7697b1eb7049@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2 Mar 4 Reiwa, at 10:02, Hans de Goede <hdegoede@redhat.com> wrote:
>=20
> Hi,

Hi Hans,

>=20
>> [=E2=80=A6]
>=20
> Heh, I should have noticed this new version before replying. I see =
that
> you've dropped the BIOS-date match. But that actually is often more =
useful
> then the BIOS_VERSION, sometimes vendors don't bump the version when
> doing a new BIOS build.
>=20
> If you only want to match the exact BIOS you tested against I would
> drop the BIOS_VENDOR check instead.

I am admittedly bit wary of dropping the BIOS_VENDOR check. As the cause =
of
this issue seems to be specifically a BIOS compilation error, it feels=20=

incomplete to leave this match out.

Since =E2=80=9CCRB=E2=80=9D in the DMI product name indicates the board =
design is derivative
of a generic Intel reference design (=E2=80=9CCustomer Reference =
Board=E2=80=9D),
maybe it=E2=80=99s better to drop the SYS_VENDOR match instead?
It seems to bear little relation to the actual vendor (Advantech)
encountered in my testing hardware, anyway.

Let me know; if you still feel it=E2=80=99s better to drop the =
BIOS_VENDOR match,
I will do that instead.

> Regards,
>=20
> Hans

Thanks and regards,

Mark

