Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CC44EE0D8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbiCaSqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbiCaSqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:46:13 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755FA62A2B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1648752264; bh=S0ikuEGsksL6QEKgy7sSSBTRKMTS3ahAMlEJon0Rvvg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VS245s8fIy5iEQmFdShsxEg6S3szR/3SbAyYw8uyJTs09aQlPxBMYATVzvoXhhUXNf2Yk8ehLfaXzyG6QcW0zfjhqbEt045qegTly8wqpS8CvpUpuvB/baBYw4tN72BAESW837pPylxiQfYWRdkJ6uWtrf3Uac50a59PD+PC8XWGOkQno3mMpwnjSDqf0S1fgY4KVF78Qc5iU1UpTHl/Yif3lBzNXprJKERRtwdiTBzYbN3UOlZFbIjTm6PRNa9+S5pZQMiRDqaT35esjQxzcFikxYjMqcbjgPZBYTPDDdOkKXXWqjmrxY1nTgov4lYTEgCrPN0aax4PT7Iymvhu/w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1648752264; bh=ZQ7jenPmEAfPsjdQbdIA6ipzzy6g4DVPxeWJY3I6AlY=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=layue1XgrBZhXQEvqX7wQY7/zO1xGnHjNaQ3OuuzJagIT1rsp0fRjFVwYVGzUWI4cteWbK2g7/sYN54M3LyhPduLZpMjjUTqf+4/VcAN//SYxdKJUMUmnfdmKuxuLe4Mh2h3ipeLfuqHpIZZh24Zio0nVyg1ofOJY9c9DhqhOT5zE825wGMYiCrgrXGQRTf0GKPotAooS+LsKrU3HfnrPsJhnXo/9KkKlfrkBHsNaAlg5IdA0Qs9CtuJj6YmY2AATOwwavzWLQb7jNKz280jUrvq7xo78sYYRCCIPPr4G92jncUZGzU+xaRNSMzO/0JHhv2CqJclRDhMU4senwQiog==
X-YMail-OSG: bejsCwQVM1lTTK.NjCoKG2fU0t.Hs4sSJEGFgswbFk1Scos27ld1BbbcS7lTL6v
 eba7XIDhoqZh2PEz2pvut7RBt0triZMp3l3eIUEI_7vkUOtjhrMEvclVOQB3jBiitJa5Scg7uxpA
 cPycnu.7uWgWZferQkqDKCbexMjiMw6snPuDqH3mredIPMu9nEkFhz6tV2Ri83LV6qX..sf65rNx
 ycW7KG.fLLysuU7s7KMMYW3unizaRc1cGTTmcf9Ve4gAp97HPkNzTzwIp_Rj2hxgMHMhaPlMnGpA
 FRFWoQO6NTaKwva85XXmu8xP31nKtMlPbxdzaD_Tf4LKYDgGtLfxXg5LE_Znzz4sAlNCKocXOT8K
 7i1kcAovFHqHOSm9ccNKy1VM9JmaYD_84n7rCLSraCJjpXzfwFj7Sl2IecIN8TGz2gKfJ7fWEvdB
 3_FV4b0OFQc_mNBb2LMAzNIwiSNGY3Isf4LrFX87CRZI5TyJG_cPEp7IUxcqx3fvQ81QikWIhZcx
 dge.f_BdPDaDoUZ4ixDoCJo.LDVW2WaR20ONQmBtFQkVeWsNHFtgKyA3RBtguZyUF2HlRUDPi6bP
 AZHfXb81va.IruSrcQAXw.uIBgAdeneC_vbFOaG0wBTCqLQGdrqwFkP6IKwI8vSIzb3qojkjSzA2
 Zc3wTQ6bDvGqgmbBBlmOljfPFfLdcc6ccdn5TSKti6VJzUYnOeu3ITn3mIy8PxQl_j_ytENdxmva
 YxuhZi2ZyJ372SV.8NBfCQCN3Nh0K93PFHGW2.EhBv10gXU.eT38ElzlCG6cW75KvmRmaRYk0zgU
 a01EUvrwyuEG0dFmwKFEBmnkQtu8gBXHRGMnZJANoUnxAZnWadCa78TnIUh951EFKdR3Ud4CAwep
 SJM3p1N6DBb8AzDZGehUyKu__.5XXIZEMFb.K85Ewg8Lajfm9pfV2ZS_muP41KmxPvwZMQ9wvIO.
 o_yvXBlpzYYYAUGkM72RkSQpFM8QNDhmB770_DDuDYAfcYgdMcYzdltTNXbbcuwk2wrg4.52Ou8C
 RCOf2Vh94F0.wOW31vh5KeJUeXYiocqKxxV3rcXxkkzJWAfRR8A2fFsk4HHGWMMH3KaM_JEUqhpv
 hf8k5QwtGRwzWofQomuvqa5qfA3GDkz7AayeARQB9Yl20LEjGslVkPw5D4W_0bKa3MRtl0tGQ9Ka
 _Iqwh55G9lJbdWs6QjdzJn3JwyZ_c.QcgEE71.f3hTLgrg3sCUul.FM2pFeKQaPigJFUV8Sx.S8b
 radjMyRC7aF4hA19mE1BBq_jS0G6ablI2fnNOAxwV18zTPr7qq12kSKuTp_h1sGyIROdzsCDEDKO
 aC.HImdR9FQ4S6MfPzXNtFmmNHk_ycutFuxB8TYBGRI4h.o3ASbC4OMFsnxkx9mLjxDKX2lDGZfi
 1LOeKjAkabrT4oqeYJjAb59TwLWEbM7Rkp5reYQSgQ6hU0B8sS5XIniCVvM9CzrH07jijgeh4vKo
 q115kl28U979oL0e.UU11BPmdBdrDdzlHhBzjfZ4Uyn_HyUsfT79wWyUGXeeyEandCkfOhyV1Azq
 BHLqaET9RgIOVgsr2MkBnTBEzrJdZMsf4Gsf4lclIa_Kn8McfWsioFuQvo4rAPmC3BXfym7iAJxS
 hRyklPZ5F1D1VkaaXrvO4126Z1ph3QMi_KU8vdblLKWNrQlPyyG4fd6gg_vmYhuBuqZIseT8wVyc
 Rm8bFmodWa31zr8N0L3VEFHu.MiboJK4YUwBnRQYuV3cYGto5WzzvQpr1fINisrAcce2T1uX90ZZ
 Ue25qpBNct4UaDv7GG5KwjL_3MNkGAyme6Tt5kx.ViEpl3E0QyJ7loSwxC9R5UbjCRhl4r78ZfHU
 yGy8Ce9KRd93Ws0NcMwjKK0ikymwekFK_aXeUkg0SX68gZ8jJs7wJE9tqefVay_7LdypJmY4LOvr
 VIDxlMvS2iDjeGAQ86xtXMYIa_iqw9dIv4tAzx6KTC0SKqUuwBCPMa2JHFKahTOK7Fsp.rzDJwGs
 D2A20NT3lDVO4yZF_BlqoSaBJ68buy4sOLLRguPHRVVgDMZLF9P1LrMnyJzoB9LPm6AMJdhGD3Ld
 qkmpbW6ypzDfikOYMtCIQfGLYL6o9FBE05xq5_UoUjgNu3mORo4mrxBg.g9k20BeeTH1FmPPMA1C
 Jv9AwX.WJj89c5qzv85vHXq0qLq2BpU5EC53SrjuwgRncLrF3uLSIorfXWkhuRKjXBQ11vb5iS5r
 s_tafD5L4IaQnhbzSU0qJPBZPCOxlkcmlOPJ1t1RMaVfQLMGg1U_CoyXfixASkKPCNxGiVR0vgF_
 ztEk-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 31 Mar 2022 18:44:24 +0000
Received: by hermes--canary-production-bf1-665cdb9985-85ftg (VZM Hermes SMTP Server) with ESMTPA ID a52cdcf988e0124571774a6608f154ea;
          Thu, 31 Mar 2022 18:44:22 +0000 (UTC)
Message-ID: <9b521078-5809-7c59-9c58-b71ee406ee29@schaufler-ca.com>
Date:   Thu, 31 Mar 2022 11:44:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/5] smack: Remove redundant assignments
Content-Language: en-US
To:     Michal Orzel <michalorzel.eng@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220331173358.40939-1-michalorzel.eng@gmail.com>
 <20220331173358.40939-5-michalorzel.eng@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220331173358.40939-5-michalorzel.eng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20001 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/2022 10:33 AM, Michal Orzel wrote:
> Get rid of redundant assignments which end up in values not being
> read either because they are overwritten or the function ends.
>
> Reported by clang-tidy [deadcode.DeadStores]
>
> Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>

Thank you. I will take this via the Smack tree.

> ---
>   security/smack/smackfs.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 658eab05599e..9e61014073cc 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -1192,7 +1192,6 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
>   			rc = -EINVAL;
>   			goto free_out;
>   		}
> -		m = BEBITS;
>   		masks = 32;
>   	}
>   	if (masks > BEBITS) {
