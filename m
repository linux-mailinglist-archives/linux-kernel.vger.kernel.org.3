Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65478536DC6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 18:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238532AbiE1Qbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 12:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238524AbiE1Qb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 12:31:29 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4568010B0
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 09:31:26 -0700 (PDT)
Date:   Sat, 28 May 2022 16:31:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail3; t=1653755481; x=1654014681;
        bh=yNybd+pfsQYttWGtEpWJQWyqOAAC9UYMKp7RUSmh9CI=;
        h=Date:To:From:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=GB8IyfBebwopq7XyIdLTJ84XDr8TDbcl9yEQWt3K/iJMKnslliUmK4FqWJz2MRjXK
         fSBpZsKiIXZgqWybGP+2Fdt2b19fBayIywe9vIa1/kmYXK5RaSJ38QPHoMghJ/kH4M
         J6f/9ZxmAAFgcCDVpIDIvF5x2E0wNYDHT4G9optlFOcLMIlX9Zqbr86QkvO+/FkazU
         kucJPvNiIa7Hpi6PsqTKYnYN3uSaxgZN1Dn6BUsUtRHznWguyvE7v7G7L5r2x9wNOm
         zX/db8GsOxbIEv7VmplCX5dUPG+lDOdz7h6nyi8H42oqyL/6ewM3PCTZAwm5IUvkcp
         4jHkNkRXWdR0Q==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   "Andrei E." <andreien@proton.me>
Reply-To: "Andrei E." <andreien@proton.me>
Subject: Sagemcom does not comply with the GPL
Message-ID: <Toz8L8u8dfFx1BV6IGj3hbRmFD31_bubFBLtaPFZ9D4D4q6C78eg_tKQ-l4MHyJ9QXPOsFUTZF5MhjXnaZI9WKEKjWIPsdOde-zEudYJmGQ=@proton.me>
Feedback-ID: 46877017:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have contacted Sagemcom about two months ago regarding my router, Fast536=
4, as its firmware is running on Linux, so that I could install a different=
, more recent version for improved security. They have not yet responded. I=
 suspect the same thing is happening with their other routers.

In the past, they have provided source code for (some?) of their routers: h=
ttps://web.archive.org/web/20210410193324/http://opensource.sagemcom.com. T=
hat page is down now. How should this issue be best approached?

Please CC me if possible.

Thank you,
Andrei Enache
