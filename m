Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A6B587505
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiHBBUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiHBBUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:20:20 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2991D2BE4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659403196; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=VOMFyhF9Vk70bPujalI0YJYY8q6H4vSi/O9fiKRe6tHSa2rwfCzySRGF3Qrm4Cy7s/91PNsqOTz9jhmURFKdArCj8vaYvack8skeQNtApbxUFrtvnggNg3PqeQHlo2AzAFfo3GDtWp4Q01tPtaMS3uz+EHZlcQ+e6Zaqlz0oVyw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659403196; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=rU5HE7G+S8wYdgR0zFTpg2lMFP9F3VFJwmvo5bzFpc8=; 
        b=J9FjbUSA9rWWrS00q5VMScDMEONgQZksK2uchnEbXlV3cyov3oSAUPUGiNAoONvrlgIt7SolEuglB25w+PSylVQxokHzLM4IHL6DkF+2qh4+k3iTzTNutYyqriU6pwdDIcPRwk9cTiK8WbA1NqyeFM9QQOfvBIwuzN7xCpPl/ss=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659403196;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=rU5HE7G+S8wYdgR0zFTpg2lMFP9F3VFJwmvo5bzFpc8=;
        b=gx5AUq2k9hVZvDTDXXo5dnc5/adA3tr0VPmTS5pQ3/KZRNofCf82+ggPIgok2so8
        QmaBfl3RFbR/1DpliWrKPi3SV0zrwxlQpU7fFMOMvdQzOF4FUL2WFuEHPweE/MSR0NO
        0G2TxB9KP7WJvRotM67446FskmQOrhTkHr76ulDs=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659403180628489.74824975291506; Tue, 2 Aug 2022 06:49:40 +0530 (IST)
Date:   Tue, 02 Aug 2022 06:49:40 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Hillf Danton" <hdanton@sina.com>
Cc:     "Dipanjan Das" <mail.dipanjan.das@gmail.com>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "linux-mm" <linux-mm@kvack.org>
Message-ID: <1825c231a32.8022993748765.3902164544656296879@siddh.me>
In-Reply-To: <20220801210655.1376-1-hdanton@sina.com>
References: <20220801210655.1376-1-hdanton@sina.com>
Subject: Re: [PATCH] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know why you would send this again, this
was already replied here:

https://lore.kernel.org/linux-kernel-mentees/18259769e5e.52eb2082293078.3991591702430862151@siddh.me/

Thanks,
Siddh
