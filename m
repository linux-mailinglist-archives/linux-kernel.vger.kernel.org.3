Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A774A487527
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346542AbiAGKCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:02:43 -0500
Received: from cable.insite.cz ([84.242.75.189]:57899 "EHLO cable.insite.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236856AbiAGKCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:02:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by cable.insite.cz (Postfix) with ESMTP id 11058A1A3D402;
        Fri,  7 Jan 2022 11:02:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
        t=1641549761; bh=tizAdbtBw+SOGeryllpWwxHMqLzcos8YC+NWd72pqU0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=X597OViHwuZn4OHb1y4j/UWAjISx/cVC+42lm3nKCMGoCPjOGAkF097CB7bDb+gd8
         4xN7y2cWgBE4mpzL8EISLKaULEEuHBeRPzQOuGp3AL/mjrC1mO7vbtPs2xLRevfC8v
         RW590hm9Bf1ogEcrt9vIztFyNe72atmagKOs/I+g=
Received: from cable.insite.cz ([84.242.75.189])
        by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CsquOWCR0EEf; Fri,  7 Jan 2022 11:02:35 +0100 (CET)
Received: from [192.168.105.22] (dustin.pilsfree.net [81.201.58.138])
        (Authenticated sender: pavel)
        by cable.insite.cz (Postfix) with ESMTPSA id 6BBE1A1A3D401;
        Fri,  7 Jan 2022 11:02:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
        t=1641549755; bh=tizAdbtBw+SOGeryllpWwxHMqLzcos8YC+NWd72pqU0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ksvbRsFtP9bsZKSlZjXDwa2VnfVV6aQvdsR7BKJAaXKoaHAO0hQ0A2I1kpENibHhr
         2czlmOz91aC9DeSQcG0D3dUI0RtIIcAhBsToBnhzNCo3wh/zh/6se8GyoQdRBppTBm
         m2OE6ke9Y0JjEau1xAzb/ePYleLiAc9zZAVYslLs=
Subject: Re: linux-next: build warning after merge of the usb tree
To:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220107024815.15dc7e04@canb.auug.org.au>
 <YdcUd19eAmI1MwNT@kroah.com>
From:   Pavel Hofman <pavel.hofman@ivitera.com>
Message-ID: <8e3fe4fb-335e-58f5-84f4-3db224525fd0@ivitera.com>
Date:   Fri, 7 Jan 2022 11:02:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YdcUd19eAmI1MwNT@kroah.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dne 06. 01. 22 v 17:10 Greg KH napsal(a):
> On Fri, Jan 07, 2022 at 02:48:15AM +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the usb tree, today's linux-next build (htmldocs) produced
>> this warning:
>>
>> Documentation/ABI/testing/configfs-usb-gadget-uac2:2: WARNIN
>> G: Malformed table.
>> Text in column margin in table line 27.
>>
>> =====================   =======================================
>> c_chmask                capture channel mask
>> c_srate                 capture sampling rate
>> c_ssize                 capture sample size (bytes)
>> c_sync                  capture synchronization type
>>                          (async/adaptive)
>> c_mute_present          capture mute control enable
>> c_volume_present        capture volume control enable
>> c_volume_min            capture volume control min value
>>                          (in 1/256 dB)
>> c_volume_max            capture volume control max value
>>                          (in 1/256 dB)
>> c_volume_res            capture volume control resolution
>>                          (in 1/256 dB)
>> fb_max                  maximum extra bandwidth in async mode
>> p_chmask                playback channel mask
>> p_srate                 playback sampling rate
>> p_ssize                 playback sample size (bytes)
>> p_mute_present          playback mute control enable
>> p_volume_present        playback volume control enable
>> _volume_present        playback volume control enable
>> p_volume_min            playback volume control min value
>>                          (in 1/256 dB)
>> p_volume_max            playback volume control max value
>>                          (in 1/256 dB)
>> p_volume_res            playback volume control resolution
>>                          (in 1/256 dB)
>> req_number      the number of pre-allocated requests for both capture
>>                          and playback
>> =====================   =======================================
>>
>> Introduced by commit
>>
>>    e3088ebc1b97 ("docs: ABI: added missing num_requests param to UAC2")
>>
> 
> Pavel, can you send a follow-on patch to fix this up?
> 

Greg, sorry for the inconvenience, of course I will do so. Please can 
you point me to some doc describing the correct ABI format? There are 
varying numbers of tabs in those files.

Thanks a lot,

Pavel.
