Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEE853B23E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 05:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiFBDqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 23:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiFBDqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 23:46:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100C03BB;
        Wed,  1 Jun 2022 20:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654141610; x=1685677610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XfoklTJKbi869hrKJiUKl238OzrlvKnxDX02pm2ToWk=;
  b=LeUsgTD7u9YRp3uS4ZwE5Fktil0u7QG/QfL1K1sQfUM9ggFe4AZTIZDd
   lG5IbJboZE5Tz1Vvz/jQ0r620LA7wbpJezimHi0GkoW9Bo0pxS2OJEv6M
   e2TYcQW/tb22cRX178CVJiOuxJADisbJ32N4We39ibexmxVc9CdBBMSry
   uXXQ/U1JVP7SKpMuz9symShDuptAOTjRi02e+3zZX7dNu5BNWruUBm9rE
   xlemkcHBde8bxUZMs4VqmXXJpYESE+OhgEuBslB7ougAN8P/Is8egPd0N
   9EHKzjG0D9VLGlpse+fSg1JqE0UnpluoN5eWaR2c63c91E4emYJiY1sY1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275884512"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="275884512"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 20:46:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="530373745"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga003.jf.intel.com with ESMTP; 01 Jun 2022 20:46:47 -0700
From:   wen.ping.teh@intel.com
To:     krzysztof.kozlowski@linaro.org
Cc:     catalin.marinas@arm.com, devicetree@vger.kernel.org,
        dinguyen@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, wen.ping.teh@intel.com, will@kernel.org
Subject: Re: [PATCH] arm64: dts: Add support for Stratix 10 Software Virtual Platform
Date:   Thu,  2 Jun 2022 11:46:16 +0800
Message-Id: <20220602034616.2840946-1-wen.ping.teh@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2cf38dea-0754-e63b-4832-a0b2aa966c61@linaro.org>
References: <2cf38dea-0754-e63b-4832-a0b2aa966c61@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wen.ping.teh@intel.com=0D

Hello Krzysztof,=0D
=0D
>> +	chosen {=0D
>> +		bootargs =3D "rdinit=3D/sbin/init ip=3Ddhcp mem=3D2048M";=0D
>=0D
>Bo bootargs,=0D
Could you clarify what does "Bo bootargs," mean?=0D
=0D
Thanks,=0D
Wen Ping=
