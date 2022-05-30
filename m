Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36E4537527
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbiE3GvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiE3GvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:51:10 -0400
Received: from sonic315-11.consmr.mail.gq1.yahoo.com (sonic315-11.consmr.mail.gq1.yahoo.com [98.137.65.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036BD56C3D
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1653893468; bh=W+smbFnqaB0SBTUnvGQ0HubD+ouh5UYnhC7rmJVGP4o=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=4BakdD8tPvH/CkDiVrID6jPKupFAuL3VNOXppgXrgOon6uhNpJeZJynvwRRwMI1S/Ewa6gA1ULwMXvDDvAYFj5X4eORN61BjX2fUmGx14tsCRd2su1Ii8whCU+0Se6e0Ejd0eMD/eRaLLRVnuBtZ4N5M8IkIcDOtatsulGS3kwA=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653893468; bh=cxBjFleibOVFx/zgW1wg9gvp+NoW2zyZ1+am/B7cfUR=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=bIXNfpqtLK1rbUD6/+fTTc9/9GCqG1Dfx2px52Vnj6y5cBND6QgnE+iDzkffUF6/7Vt6spVZHUFY2vfLQeJX/2FgR62lCjsCn8UnHLA4PNYya0XpPWwLTHQwXP9BFWYav1xbYxCVYByAsByJmon3fqHAHhv6TvkpdKedt4XQZgQZOUM0RTTtconcAs34LVyDUZTrGy9oaAiWNFQdLvbBNfLvD9NI1l2ZIGlXKQQoLfLUU3I8DiiHbxeAzMc7DPPajs7VCRV6LPh3RJTE3c53WkyaPCr694sBX3rQZMz5BTsfLV+soIvs1hhm78L9UHNkAxfvLW9a68pJZiT+QajIaw==
X-YMail-OSG: 1SxjT5cVM1lJjA25MHdBJ6g_ymZL_js0XxQ14lEwy8v7uHE4DOw83gFMTKxb1sR
 VRm5bViephXe9CcDWIcDqtkbPX7zBJDKIeTOQpct2PbfAxupElKco90Q8.O_Y21v7hcfYUzAHPzc
 1KaJamA97OxamgVL8IIWynmbOCLByil2Nr347_wsES9vkMHFa5cvn7eD0ilSX9yFZKj0mT01CjRK
 H5d0v5EflolMyZXS46d6kYUuwlnE4EA.GhF3ek23zgvKNS6UWbxcYG6XiUBKByJL_Tv4V3BrxqJO
 k_VAXLHLUubS0gmRLsYv1Xvw5WX2vFQLfA7IJ2_JmnJ7RKBdhXAAFt3.Cg9UsaKBmgtJmS4YFud3
 bGzsHgyLx.cftAvJsNWmtqN8hCzHkFKjJk9VhRNQ1agh7U.twPl.6h3mAD__YKAKU4aXw7q65uEv
 7.IgWF.ZlSHhotBvVARpGLpnpF5rzfXTbWU.3tbNR3lCPOoNlcKv1vMjrUiSor7Bwg4Vkl_o83DF
 o0m5e46wXwJvtg1DHPEgz48rZIKE2TPUE2iablnSNGCuyPn92a4yEYwOSurQZid88fmXzuS4iPfm
 3khj2b0GAJVfA5ketbxl2Mvo2Ai6bvZN3qqHPiCKkcMZ_DDNpfCCDPwPUmnpo2bPAe.c2LIDqQ2V
 BvMoxaF9PPsC9ZuARmkgc4KZDhgk2QDcleZcthTk0RNAEeUJnPkGHjKXkk1BByfxK39AVYdZRGlm
 BmLih3AIULU8JZ98ffdRgkHU.S1O4rVC9Bb0YMUUkUVJuoGkrgnvivX6arT.cNTtM57MuiRfu9xP
 btMR10CJQvO_jBxOMRVN9Dnaw.PygscZI6ZSTVWWDpLZpcEtkrFHHGZK3mI0qtNC6RD_eju32zA1
 8s6_h528SocBcviAAYiS4uB_Rl0UEhOPh.VYlkF.wsE5rIPeteyR7eIvk_ElvOjrIDhLvUE80TXd
 dqEPbpK6lZqbwsdWKPJ9YWSd8d_Ow2ho0xQVCaBL913ymLegRYmBF6BF6Cm5VNKsOf.iefFTQd2L
 iFUW9lU4St8u3t_G7HY0OL1ME.VSzlfibcNsHhMohDnIaEncFhsUlad59vGt6WZj0s1Ii45nX4ic
 6UtB5TPZi27CqiDi0TCjEy1a_ICGOB3mgA1lqdIqLDiDjpLCX7baf_kDzGpm0Lz.pRF8zwJaXysf
 5VaI4d.V5Lw3EF3vZ6w0YnvzqnxZvfWTMWBtZvTS2fkMvqdyalk6i1QqE0DishX4afUrR9a2tnLF
 yXE7K0C4jInuRbiosKg3konuKSrHFFJe_Ktd.v71mvgM8Blk15P4nqZLY9DFuovjK5kTwumPuOKX
 jPFUm_3hid2lCoXoJNTDlmEhGcuG2trU8dvZc5doNgWrF9vc0ECPVcDO0c8fnAGl5L0TFQksj9I1
 txjatdV4FfMy1eu390AKO8nVdjmoRPE1HDWD2X3EI84xMaY95Ewl91vk4PtcTwRWAoZeTMLiC28H
 91p3vnaouYUb38uFvs7Du.CtSddgUZHYHCYS_2YO.MuauhVEufpgAU_6TxcTDb.QHW0io0CCt_Ot
 ZqVmJCJfe2ZlFcS2NrfyCAivfm0hs7WCvLfRJWrVU3kuwHaIcQdGn72xh_TvZ.aI73cPIvVzLFUv
 BRk_unMUcuBd7YD2118SekkyGQFFkk_9ShYoxm_xr_ik.cxmqqiQo7jjW23_J9gXhlGRoX9pPLRx
 02hC_ffB1s39WWUel34mLxYLS5t5JonT6rrRLadvUMziv0x._NyExw76ihefJqUde.od9ABRW.uw
 QOdhBDQF8tMmcM0uq0raBeTiDP3LF3j2yzn8MCEupDftK6iYJ3M.WSx.vuAhuJf6y9GaNWEG3ede
 J7vOMO2siJP2sbr8JinbDrjm9OxzqCub8B.wRf3pFve9h6QHfHrqtN3clWEDE1rau6A6nyeLfEct
 YO8VrlcGHdvGu2BpNnzXGhrD150kbQTE567O.CTHITRZXekudNi.ToLQlGTIaocqVIifPG9q3G0Y
 sbpSClblbM2FK05ogpsCUHXmIebodMIlyu3Vt_rCMjalNqQTJDwaAGaAZUxDBSodO8MXIzZr7D8T
 VkvzOGP08sPZxhF2iZzmEJiumVlqwKY34o9ieubCM3oR_uEtuobbO0q9ysurVu0cCWnAWgEJIjJG
 sX1hHLff42nrT8ChBP_DykK7K09c79VyPVjaj.5iGqhFY8ZomlxsSej3t11sj0nHF5LmhJ6Ib8IC
 keDNSJg73DOkt0UbHkkokCRcxHSjWZ4lX.e4SduLHU5Ggwd1oAIuR0iMDyMHVY60DHdGP.B3OqW4
 UvyZQ04k0roYHoVXSPE_UAw4-
X-Sonic-MF: <lesrhorer@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Mon, 30 May 2022 06:51:08 +0000
Received: by hermes--canary-production-ne1-799d7bd497-rcgtf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 38368ed578283a18e64a511e8c6fd2f4;
          Mon, 30 May 2022 06:51:05 +0000 (UTC)
Message-ID: <486038c1-bac9-c66c-826f-32fa41aa85e4@att.net>
Date:   Mon, 30 May 2022 01:50:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Module failure on new install of Debian Bullseye
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
References: <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0.ref@att.net>
 <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0@att.net>
 <7999b7b4-3b58-a9c4-4756-445e54404f0f@csgroup.eu>
 <ba2fb3ff-22dd-d68e-fa99-02de39240f20@infradead.org>
 <3b8f2ed6-11fd-b5a7-5442-7cac90348514@att.net>
 <22c909ae-1bd5-731e-53e7-ff6e0b47c7bb@csgroup.eu>
From:   Leslie Rhorer <lesrhorer@att.net>
In-Reply-To: <22c909ae-1bd5-731e-53e7-ff6e0b47c7bb@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20225 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2022 1:11 AM, Christophe Leroy wrote:
> 
> 
> Le 30/05/2022 à 01:45, Leslie Rhorer a écrit :
>>       If this is the wrong list, please let me know the correct one so I
>> can subscribe and post there.
>>
>>       Two of my servers are having bizarre problems after upgrading to
>> Debian Bullseye.  After attempting numerous fixes, I decided to wipe the
>> systems and do a fresh install.  I did a fresh install of he first from
>> a netinst thumb drive, but the .iso does not contain the bnx2c drivers
>> needed for the ASUS PEB-10G/57811-1S 10GbE SFP+ Network Adapters used by
>> both systems.  I tried adding what I thought to be the correct non-free
>> drivers, but I still got errors about the bnx2x drivers and the
>> interface shows no carrier.  Since no carrier is detected on the
>> interface, no LAN or internet access is possible.  The system is
>> effectively dead, although it boots up and of course I have local
>> console access.
>>
>>       After several different approaches, I changed from the netinst
>> image to a full non-free image.  It still would not properly load the
>> bnx2x drivers.  I tried downloading all six bnx2x e1, e1h, and e2
>> release 7.13.15.0 and 7.13.21.0 firmware files and adding them to the
>> initram image.  It no longer complains about missing files, but it
>> doesn't activate the NIC, either.  These servers are both essentially
>> dead in the water until I can get this fixed.
>>
>>       The only thing I spot from dmesg that seems possibly related is:
>>
>> ...
>> [   12.976323] r8169 0000:0b:00.0: firmware: failed to load
>> rtl_nic/rtl8168f-1.fw (-2)
>> [   12.976478] firmware_class: See https://wiki.debian.org/Firmware for
>> information about missing firmware
>> [   12.976632] r8169 0000:0b:00.0: Direct firmware load for
>> rtl_nic/rtl8168f-1.fw failed with error -2
>> [   12.976636] r8169 0000:0b:00.0: Unable to load firmware
>> rtl_nic/rtl8168f-1.fw (-2)
> 
> Do you have that file rtl8168f-1.fw in your setup ? Is it at the correct
> place ?

	I will check.  Without remote LAN support, it isn't very easy.
> 
> By the way, this seems to be more a Debian problem than a kernel
> problem. Have you asked your question to Debian support ?

	They and I do not get along.  More importantly, while at first glance 
this might seem to be the case, I don't think it is. The github 
repository at

git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/bnx2x/

	Is not a Debian thing.  It is a kernel module thing for all distros. 
It is from there I downloaded the firmware (after it failed to load 
during install), and it is that which is failing.  As I said, it could 
possibly be the realtek drivers also need to be loaded, and they are 
not, but I really would not expect it to be the case.
