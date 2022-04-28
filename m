Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783C951365E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347038AbiD1OKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348166AbiD1OJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:09:51 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E25AB7156;
        Thu, 28 Apr 2022 07:06:25 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0C7AE37A;
        Thu, 28 Apr 2022 14:06:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0C7AE37A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1651154785; bh=Y2xnGB6jAuDv2OSGOPccTS08t10lDzVVPJqY/azBkxg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OVHg3XH3CV9h4WnwpB2QxRGv+qWAAHo4xnpjabp5fV5kID38tVUqBcoQb/pnL6uEW
         8uEBwaOrzPgltzkqwiAkUJC60V7i5i9pZR7pK1CtmDV3is9OmJVRZwY26IjQW7s3jv
         CMCxbmk0SG1T5vMmpG1PCmPYP0uxSUMif3pUTEfWrAsoztJO0y6OCxcBc2p43MALWT
         pCcXF4h/bwXdTG2ys8XqOF4Rw80L06yY/H34TsErdOPu1iyUN00nPKz+p8ysCdsDvv
         iUDXBmLwd0194Q+P+qm6aL4QJMBB9LIJQ9OgFWCrreh39iOIcS05DfDxm+MRr0189i
         Fm/M6V1Cr2zdQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joerg Roedel <joro@8bytes.org>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com,
        bp@alien8.de, mingo@redhat.com, tglx@linutronix.de,
        Suravee.Suthikulpanit@amd.com, will@kernel.org,
        iommu@lists.linux-foundation.org, robin.murphy@arm.com,
        Vasant.Hegde@amd.com
Subject: Re: [PATCH] Documentation: x86: rework IOMMU documentation
In-Reply-To: <YmpNevdJFec0+9Mn@8bytes.org>
References: <20220422200607.627754-1-alexander.deucher@amd.com>
 <YmpNevdJFec0+9Mn@8bytes.org>
Date:   Thu, 28 Apr 2022 08:06:24 -0600
Message-ID: <87ee1h8fq7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Roedel <joro@8bytes.org> writes:

> Acked-by: Joerg Roedel <jroedel@suse.de>
>
> Jonathan, will you merge that through the documentation tree?

Done.

Thanks,

jon
