Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AA547E0D0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 10:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347428AbhLWJW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 04:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347405AbhLWJW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 04:22:57 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5607FC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 01:22:57 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id a37so8025606ljq.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 01:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=WHOhD0vfbpW2mxOuX/ZSu0GT+AI3C/oXcOue0WpYD8Y=;
        b=PgO00WqqHBOsMXHTZYGjfCuDUrhR9MXclWcowP6FKyiInNYCbxM2EADQW2U8B0CsNG
         zdm6Rx7fRNxBW8eh6Ri96DMZ2/TSkO8IT0x5attIz3CCZPDxptBtJmWonPDHkdczSxcl
         KLvpLWs+gwunjp+nrfwfhjO+F6wZdem/gaJKvD+IEz8lVPpRAGJBtzwn1/0ok0djUEPi
         q9gaPd6wefSsutTlBBpx3v2vMMEadK3exmWjqlEF/+JQq2XU+sroCri1ycYzvfxL3tcK
         UEjMvbvFIQKV37HY8FEhvTwgKL+QQ2zSV6gERF57oe8OaegfJvOoYBjwZHokm+DZL3RA
         VIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=WHOhD0vfbpW2mxOuX/ZSu0GT+AI3C/oXcOue0WpYD8Y=;
        b=gszWSImJQaaWsEU1Aj7G0WesQkWcAIZPiAWo0MEWfmIEzB1HEqrze7aFEAbzaDUrIE
         GC2aUFThcnOAN8gHIzSPkjrMho0tkV+Ns473C4ndNJuG/xwgqIoDKaDof1O9CNlNTCPO
         yBMjP3EwhZaER8PDYiSIYBcUOCLfl7WHfK47uumbZcRlSyqMucwSd/AkINJ6UUhF1e/n
         x0tScvfcPMMoLECX+fmEWCpCuhqrOVV1mF8GW/1t1xvnNrb9nECfKjS8BlWAM0++uoFv
         8FfPIstJLvX7a9cQZxFT2ee6u2p4FpcK5Lz62nMNcsUFpwX4jgPvuOdMujssACcJNoTo
         RLow==
X-Gm-Message-State: AOAM5333tEH47h3aalNNUOdJuyWhpPJk26HhEZcm/NrxpOY83XRFVEWQ
        dZbEAULNA4uopWx4m37DvdfC3M+3qoAddCGEXcs=
X-Google-Smtp-Source: ABdhPJz55OAQFGz26XVwCeELfp9XL/ygo3EpZHAsXrWqxX3ZZscfuo3NpWIKnaf5H49LNigrcQa9HzVMR00LWy7k2EE=
X-Received: by 2002:a2e:96d0:: with SMTP id d16mr1108178ljj.330.1640251375062;
 Thu, 23 Dec 2021 01:22:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:88ca:0:0:0:0:0 with HTTP; Thu, 23 Dec 2021 01:22:53
 -0800 (PST)
Reply-To: camillejackson021@gmail.com
In-Reply-To: <CA+gc9O4Xrxcnwi+kSOaOu0F+fA7QRcCF_j+BxTAZbc=t1UuNXg@mail.gmail.com>
References: <CA+gc9O4Xrxcnwi+kSOaOu0F+fA7QRcCF_j+BxTAZbc=t1UuNXg@mail.gmail.com>
From:   camille jackson <aminoutchanile@gmail.com>
Date:   Thu, 23 Dec 2021 09:22:53 +0000
Message-ID: <CA+gc9O5ySr-FbXwfX0XR6v-EwBkYH55NN3Q4y=xhPgeM4nxAJA@mail.gmail.com>
Subject: =?UTF-8?B?4LiX4Lix4LiB4LiX4Liy4Lii?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4Lin4Lix4LiZ4LiZ4Li14LmJ4LiE4Li44LiT4LmA4Lib4LmH4LiZ4Lit4Lii4LmI4Liy4LiH4LmE
4Lij4Lia4LmJ4Liy4LiHIOC4ieC4seC4meC4q+C4p+C4seC4h+C4p+C5iOC4suC4hOC4uOC4k+C4
quC4muC4suC4ouC4lOC4tSDguYLguJvguKPguJTguJXguK3guJrguIHguKXguLHguJrguIkNCg==
