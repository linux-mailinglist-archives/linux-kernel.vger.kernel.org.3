Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0285493B17
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354804AbiASN1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:27:46 -0500
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17437 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354648AbiASN1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:27:45 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1642598848; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=n7KdY5O1IbkTGFTFg/xlnfZdjpPH5GaTWxvNfw4i1t+32loGtX+GAERcljh3UIUbKF7UX8tbKhfAmdUsf5mv/VXKW0SH8EiCemqY4H6eWD33C64wNOMikfHa9cNTDg9nnC5PYGJ0+5eJkK2JuTJml/5cCYqLKrf/u9lxXXirbAI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1642598848; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=vYkKrZxCG/cKt6+IIDyfS1RNbgmwpgZCPpOYO0clTEo=; 
        b=Gc/LqWYOFdrhAhVTy+Libkdux8VwDwDeWdBZREpUm2FDF3wJK5c75miXorRp6t9th9ZcLy89sUwD+EfjEY5EPJPHf3Sd/xhiwgBEC+6KXRMcW8DczAip64KQmJLI+g/m7vyOX029hp8kpuUhXEySNWGidEj8+b1SKy2l9AclwLQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1642598848;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=vYkKrZxCG/cKt6+IIDyfS1RNbgmwpgZCPpOYO0clTEo=;
        b=ZAGDQczAj1fTsc5MR8Nkb36EgQSc5u+YHbIGUPTUIFPQaYIvaLuTKqjqL5i2varu
        WudQAAJOca0zc9SQbAGb7qt+SL+52gwh8DPPssC+2Zlp50r5cS+fUJ07CqeYXxZMBV1
        fqCw8SNNq4s8jz7z4NRoXldsabFr3tBcj2dP59YI=
Received: from [10.10.10.216] (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1642598845836963.4816161923367; Wed, 19 Jan 2022 05:27:25 -0800 (PST)
Message-ID: <d46fcc03-40f1-edbf-e966-e35aabf84111@arinc9.com>
Date:   Wed, 19 Jan 2022 16:27:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 0/4] clk: ralink: make system controller a reset
 provider
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Cc:     john@phrozen.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, erkin.bozoglu@xeront.com,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>
References: <20220110114930.1406665-1-sergio.paracuellos@gmail.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20220110114930.1406665-1-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the SPI & MDIO probing issues we were having with our 
mt7621 board.

Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Cheers.
Arınç
