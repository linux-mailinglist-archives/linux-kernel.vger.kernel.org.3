Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277335336C6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 08:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244147AbiEYGeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 02:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244135AbiEYGeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 02:34:07 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFD24EA13;
        Tue, 24 May 2022 23:34:05 -0700 (PDT)
Received: from localhost ([31.220.118.249]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N0FE1-1nfX7s1UE3-00xNHI; Wed, 25 May 2022 08:33:39 +0200
Date:   Wed, 25 May 2022 08:33:38 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     Li Zhengyu <lizhengyu3@huawei.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: srf08: Remove redundant if statement
Message-ID: <Yo3Nwnq58tjKp3nl@arbad>
References: <20220523122755.90638-1-lizhengyu3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523122755.90638-1-lizhengyu3@huawei.com>
X-Provags-ID: V03:K1:WuCXsISV+LcR2fiPYceeJ/1veCe1id+9u8nVSBSHAaEPTL1EMfD
 /HdLCkq1VkRj6PAc3I7PdNOlqhg8av/+vc4icCrIsjRb2rzcgEDOah1UHgl5APpDftlU849
 e7vK+JdOK4qAj7pWFYxqvaxAcnm9h5X8lIClQD9ImeC2GSbdJqsbXKduJigPMTIQcTC5Hpg
 sQfwvUPOcKJXzMMPUCQyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/5SOd4ZNpR4=:bpPXgQM6zMLYq/zKz9NmA/
 VkabMv9XhdOQslnElnrZn8GJ/1q4+84tbGPumWSEj7Ql806RI7InR4MWQrd/ZA8FsACXFyw+9
 /tKNscZCOD87R3KE/TwY41PpZFC3yhEVEH6a5PNDsD0z/Qg7/o656TsT03e8c4CIT3h9qDip7
 V//B9wWAGilx3UzmyjwvMJ5qek0Q6UXfS+dEoGlSRW/tln3Sny4RcFhddAXKnLnNg8BeHHtDJ
 wn4D2HxHHDL7llBlXkBynl3EX5jECMJgbR7fk3iUVaUnlePUvknG9QQCG+9n396PM/Zrp7JUH
 hL/nEK34IkQe1yb562X5pebpUUy7NjuR6GQZcOcHoVm36VHDjTIQzNOSNmv9ObEcO1jqBkhDK
 Pf0i40mctf4SKfQJfQqdY7NJo6h0SGe5SveOM91/yLPaRX9+YpQpp1JzXUfx/gJJokDvS24Pb
 e4TSY8u/s6MsLJESIXacg6I2wD4pDjLwgxV0cP3DVNhfIVtTgpVvqXr72wO+9N/0Mr8eLHBUG
 GsNUynfggNp0Jwx9VfoQODPPrqom4UifpJ+2KEGBUcb8gCQy8oQQwz0fysBopEe2UtP8Sx2rR
 yotz7TtX4uvx1RCHOJZD5nx6LpHnBODNCWNdm27NmaCH1B01r3mQGwEaVv48VnJ3mQv51ozbT
 MtUBoqB8EMV2pCg0noTeUH3wwPiJKYoPAEPKMKCqtMqYdyP2KR+sX0ZNlX8AcqWDNUi0Mq/QD
 8gDvdMpAHmfzbbBX+zKVm3Lp+ELVtMKvAa+unQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Andreas Klinger <ak@it-klinger.de>

Li Zhengyu <lizhengyu3@huawei.com> schrieb am Mo, 23. Mai 20:27:
> (!val) has been checked outside the loop, remove redundant (val &&)
> from loop.
> 
> Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
> ---
>  drivers/iio/proximity/srf08.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> index ac1ab7e89d4e..7ed11339c31e 100644
> --- a/drivers/iio/proximity/srf08.c
> +++ b/drivers/iio/proximity/srf08.c
> @@ -354,7 +354,7 @@ static ssize_t srf08_write_sensitivity(struct srf08_data *data,
>  		return -EINVAL;
>  
>  	for (i = 0; i < data->chip_info->num_sensitivity_avail; i++)
> -		if (val && (val == data->chip_info->sensitivity_avail[i])) {
> +		if (val == data->chip_info->sensitivity_avail[i]) {
>  			regval = i;
>  			break;
>  		}
> -- 
> 2.17.1
> 

-- 
Andreas Klinger
Grabenreith 27
84508 Burgkirchen
+49 8623 919966
ak@it-klinger.de
www.it-klinger.de
www.grabenreith.de
