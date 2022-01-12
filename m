Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F1E48CCDA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357558AbiALUHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:07:15 -0500
Received: from neo-zeon.de ([70.229.12.130]:38110 "EHLO neo-zeon.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235331AbiALUGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:06:49 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jan 2022 15:06:49 EST
Received: from neo-zeon.de (localhost [127.0.0.1])
        by neo-zeon.de (OpenSMTPD) with ESMTP id 9f1b631d;
        Wed, 12 Jan 2022 12:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=neo-zeon.de; h=message-id
        :date:mime-version:subject:to:cc:references:from:in-reply-to
        :content-type:content-transfer-encoding; s=1; bh=LsQgZUAtXz/CTWd
        vR+KQLZhrZLQ=; b=wsOGnqtYjqstNcf7G/2jAkEC5VZEL5+9SHA5IVcodgyQTje
        X676QXMnB6oKzRNX6sOBC//iyw3Le/JUTIZ2cMtnaCBm7gvWBQ8/Z4cGOpvShGxf
        p/1OYtuujlRWI93qlm8afXMHk6gt5kgsIM9ARZEjWKXQ+m3IagHUILEZ80Rc=
Received: by neo-zeon.de (OpenSMTPD) with ESMTPSA id 04d3b972 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 12 Jan 2022 12:00:07 -0800 (PST)
Message-ID: <3f042293-05de-d472-dd6e-ce5ca3a8331b@neo-zeon.de>
Date:   Wed, 12 Jan 2022 12:00:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v6 08/10] ACPI / scan: Create platform device for CLSA0100
 and CSC3551 ACPI nodes
Content-Language: en-US
To:     Lucas tanure <tanureal@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        'Hans de Goede' <hdegoede@redhat.com>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     "'moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...'" 
        <alsa-devel@alsa-project.org>,
        'Liam Girdwood' <lgirdwood@gmail.com>,
        patches@opensource.cirrus.com, 'Takashi Iwai' <tiwai@suse.com>,
        'Mark Gross' <markgross@kernel.org>,
        'ACPI Devel Maling List' <linux-acpi@vger.kernel.org>,
        'Mark Brown' <broonie@kernel.org>,
        'Platform Driver' <platform-driver-x86@vger.kernel.org>,
        'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>,
        'Len Brown' <lenb@kernel.org>
References: <20211217115708.882525-1-tanureal@opensource.cirrus.com>
 <20211217115708.882525-9-tanureal@opensource.cirrus.com>
 <CAJZ5v0jTELqFeO6q6w_mYNo_yf1R9SX66RrEz0ZSe27w7E6kog@mail.gmail.com>
 <4b5506b1-20c6-3983-d541-86dc2388b2a7@redhat.com>
 <004001d7f5c6$7329d4d0$597d7e70$@opensource.cirrus.com>
 <e2d39d52-c139-a94a-94cc-88841d3638e3@opensource.cirrus.com>
From:   Cameron Berkenpas <cam@neo-zeon.de>
In-Reply-To: <e2d39d52-c139-a94a-94cc-88841d3638e3@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Will this also include adding support for ID's matching CLSA0101?

Thanks,

-Cameron

On 1/12/22 05:05, Lucas tanure wrote:
> As the ic2-multi-instantiate patch chain is still being worked out, we 
> would like to submit a new chain for CLSA0100 id and a few fixes for 
> the HDA cs35l41 driver.
> And to avoid conflicts the ic2-multi-instantiate patch chain will wait 
> for this new patch chain to be merged.
>
> Thanks,
> Lucas Tanure 

