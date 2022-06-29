Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEE455F981
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbiF2HsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiF2HsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:48:00 -0400
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B0E38DA6;
        Wed, 29 Jun 2022 00:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656488873; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=DhK++zDkXH1xcTO3PgDvNVPur+HbX+iFbKa1Dy3JwVudvk/J6kwDtSMH15/vCi7M2VF4tBv7sXzazBpNiIHJ4IfKD4VwsIR0Ioh1Kl2OtyTHrgtqx3YfOJQh15G5/d0tmlXjoURKbdkbGZFwjRVRIfN0A/6iaeooOCrDE0ggdBo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1656488873; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=RrVeZTg3W+OqqISkusTJIHrK51fZ7mNS1Xl+uRCbfBI=; 
        b=PZl0bBKKCMQgIt7dALGTnLE6AAIof/munAO29KIgM8ousmOa9rxE3l1mJv4b17qPGBQ0xeQdZglW8n2F7ioFp9TzoOSAzBm5rMQUbPxFCkj6CNwpSSu9gGpddMjW0W2dg0Abh6AIznwf0kmmxcgbJyPEkzLhRCG46N/wAR4YlZ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=gvisoc.com;
        spf=pass  smtp.mailfrom=gabriel@gvisoc.com;
        dmarc=pass header.from=<gabriel@gvisoc.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656488873;
        s=zoho; d=gvisoc.com; i=gabriel@gvisoc.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=RrVeZTg3W+OqqISkusTJIHrK51fZ7mNS1Xl+uRCbfBI=;
        b=PG7IbTzVwhcLWDBsh22A0w5O1qjj9977tb1mX3C4Nd0x560GwmIClkTPd7RPl7UH
        40OfREl/PIEo0hKWVxzarMhSAX9uswd8aHmjveoYV7RbQ882z18rhI5MoL8nTW+lWrD
        3v+zSAl/a8hEPan8KUjUbyIZVE8GgzJC7lYQtQl8=
Received: from localhost (61-68-176-95.tpgi.com.au [61.68.176.95]) by mx.zohomail.com
        with SMTPS id 1656488872842632.2175981479204; Wed, 29 Jun 2022 00:47:52 -0700 (PDT)
Date:   Wed, 29 Jun 2022 17:47:48 +1000
From:   Gabriel Viso Carrera <gabriel@gvisoc.com>
To:     Greg KH <greg@kroah.com>
Cc:     Joe Perches <joe@perches.com>, andreas.noever@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: Thunderbolt: ctl.c: Fixed comment coding
 style issues
Message-ID: <YrwDpD+MaNPN+Sl1@vao>
References: <20220625084913.603556-1-gabriel@gvisoc.com>
 <20220625084913.603556-4-gabriel@gvisoc.com>
 <1a35d3bdf6adde4f21e7c1401f3a2aba64367eb0.camel@perches.com>
 <Yrv3PTCgzZGu3l8j@vao>
 <Yrv5HLEXHL+iIVXq@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrv5HLEXHL+iIVXq@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 09:02:52AM +0200, Greg KH wrote:
> If you are just learning how to do all of this, I strongly recommend you
> stick to drivers/staging/* which is much more forgiving and welcoming
> for basic coding style cleanups.  After you get some experience there,
> then go out into other subsystems.  Many subsystems do not like coding
> style fixes as it causes conflicts with other development that is
> happening.
> 
> thanks,
> 
> greg k-h

I am doing these patches as my first step, yes.
Will do as suggested, thanks for that. 

~Gabriel
