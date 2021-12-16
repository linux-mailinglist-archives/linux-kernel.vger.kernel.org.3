Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78943476A95
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbhLPGqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:46:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37930 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhLPGqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:46:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8308AB822D5;
        Thu, 16 Dec 2021 06:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F96C36AE4;
        Thu, 16 Dec 2021 06:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639637171;
        bh=r2Y+GjX5e/u0eXEE0tEbkKF/KjAvJAimzMqFv0ZBGYU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ADCsw8pfq2mOoE1ULgtQ8P6dcADLMTui7q7yRxQPQcQxvtrSUMpSF5c3T4IgBuN4R
         6rt4PLhvQgD742ygjyggvrIrGDg6H+ZoqtOvIKjGOFcloXgKpH+J8LO0BLYx/g23Jd
         MNNMKGSMNmNGdFvWtw6WTfoy7nHC9lJ150ChrXfXVjnQHjXe1YHJO1VHONfZAQi1S2
         V+iOLKVbqXm/UWnyw6TXa9S4xbgpAdwiKUFtT3Vq4Uk/c3WIgqiclm4cbu0pXz8Yzz
         wPEIJBCh9tzCVP2sheG9cL+lt1XbhSSe7Kk1AAhK6INULJehZj+N+XlyTKu/hwabgX
         gk/TzozCFc1DA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAL9mu0LVBSorMK9KbZ3kXYcnubi44yPDxzMroKYVYB2c=o+xjQ@mail.gmail.com>
References: <1635232282-3992-1-git-send-email-dillon.minfei@gmail.com> <1635232282-3992-10-git-send-email-dillon.minfei@gmail.com> <CAL9mu0LVBSorMK9KbZ3kXYcnubi44yPDxzMroKYVYB2c=o+xjQ@mail.gmail.com>
Subject: Re: [PATCH v7 09/10] clk: stm32: Fix ltdc's clock turn off by clk_disable_unused() after system enter shell
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, gnurou@gmail.com,
        ezequiel@collabora.com, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        mchehab+huawei@kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        hugues.fruchet@foss.st.com,
        linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>, open list:
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org, llvm@lists.linux.dev,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>, ;
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
To:     Dillon Min <dillon.minfei@gmail.com>
Date:   Wed, 15 Dec 2021 22:46:10 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216064611.45F96C36AE4@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dillon Min (2021-11-11 18:40:09)
> Hi Stephen
>=20
> Would you pick up this patch? Thanks.
>=20

Ok.
