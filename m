Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE64464B35
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348476AbhLAKKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:10:39 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:10275 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242474AbhLAKKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:10:34 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4J3vrp3PRzzBs;
        Wed,  1 Dec 2021 11:07:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1638353228; bh=jI+a/MwfWRbDEo5BWhC1Hzq/9z1sn8ojrhhDKyLGh8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=isJt0KIY/WDqINJs2yVBaU76Rzew3yyG4cDIgqEQcRMpvQwxxT4vOgrwQQ0I8z5ka
         ym44vUZPixxSbzNkx+UK8XCE+ssrJGVqUGI2P/81u4+mCUA3SYEQxD9TKi6KW8IhfI
         gv74fiGrrZ1vs2A/hG60WnRs+aDAnIS515rOGBxdoGiF7jT+DAr9VIN3ivpSMJwo9b
         iL7z0IOEPVQRLb5eFA9F/ZP08f8YQzMIwgWjyUl2Ps8h7NK1SeFOUxOPeANYebnUEI
         qPW0gTUzjG0xUUv1RV1ZQAygyYoLG0lxP2UgFqRDc69gHkUbFT1VYyY71Ii10qalka
         QVjjV4kciqNPg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.3 at mail
Date:   Wed, 1 Dec 2021 11:07:05 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/24] ARM: tegra: Add common device-tree base for
 Tegra30 ASUS Transformers
Message-ID: <YadJSRww8we7tzjP@qmqm.qmqm.pl>
References: <20211130223820.23609-1-digetx@gmail.com>
 <20211130223820.23609-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211130223820.23609-7-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 01:38:02AM +0300, Dmitry Osipenko wrote:
> From: Svyatoslav Ryhel <clamor95@gmail.com>
[...]
> +	i2c2: i2c@7000c400 {
> +		status = "okay";
> +		clock-frequency = <400000>;
> +	};
[...]

Nit: You could now use the new controller handles directly - that would
avoid some indentation and duplication. Though I understand it is a lot
of tedious reformatting.

Best Regards
Micha³ Miros³aw
