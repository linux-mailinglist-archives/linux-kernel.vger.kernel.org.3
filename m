Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA4B4B64C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiBOHv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:51:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiBOHv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:51:56 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5A9BD2F3;
        Mon, 14 Feb 2022 23:51:46 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aee0e.dynamic.kabel-deutschland.de [95.90.238.14])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id BD95F61EA1928;
        Tue, 15 Feb 2022 08:51:44 +0100 (CET)
Message-ID: <55f5c077-061c-7e53-b02d-53dde1dd654f@molgen.mpg.de>
Date:   Tue, 15 Feb 2022 08:51:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: New warning: ACPI: CEDT not present
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#regzbot introduced: 2d03e46a4bad20191d07b83ec1242d5f002577be

Dear Dan,


On the Dell Latitude E7250, Linux 5.17-rc3 logs the warning below 
(`dmesg --level=warn`):

     ACPI: CEDT not present

I think commit 2d03e46a4bad (ACPI: Add a context argument for table 
parsing handlers), part of Linux since 5.17-rc1, is the reason.

If I understand it correctly, CEDT is not to be expected on older 
devices, so the warning is not justified. Can something be done about it?


Kind regards,

Paul
