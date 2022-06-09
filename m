Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BF6545467
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345111AbiFISuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiFISum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:50:42 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF5557165;
        Thu,  9 Jun 2022 11:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iykuuLk9BwHHYeA1HpQj8nLEAJPoZ/3GREkwxiSMgf4=; b=XrGia3xQqi9CpwRE2cykN8qOUi
        mb8//lLLKbYzulvVx5/2jTAbjlRVFcSRX/vFzdv4dCUMISgZQqHot4HQAMnjeS92ZDvYj6zt5wS4+
        E543fkLKbNpMJYorkfoUzhLgcRB7yegiT2mZIrcRyDajzhyZxTHxcYhyFpe0yLI2OUG1fAyz11br2
        IVyKdgDk8xFjHZWwXlWm1u+T4Uuf1o+7RySoS7UE93NVDAMKo7/zPmV2Ka6AfbKWaNz0wa6lqL+F9
        3oCFEHTBoPuF0Oq1qWtIRAlCKgHZxn77s20yEDz2JulUAhWKW5nU/AUH686bq1NMr+FQ3uhAQPh/H
        rcEyqU6Q==;
Received: from [179.110.79.194] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nzNEj-00FT8g-6F; Thu, 09 Jun 2022 20:50:29 +0200
Message-ID: <98198760-59cf-43de-38f8-1a76af60fbb4@igalia.com>
Date:   Thu, 9 Jun 2022 15:50:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] ACPI: processor/idle: Annotate more functions to live in
 cpuidle section
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        kernel@gpiccoli.net, kernel-dev@igalia.com,
        Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220607222458.1864805-1-gpiccoli@igalia.com>
 <CAJZ5v0j-g66TEizAV+j5it_uKkf+=+259yqNNkzJjUtL79=d9w@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAJZ5v0j-g66TEizAV+j5it_uKkf+=+259yqNNkzJjUtL79=d9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Rafael =)
